# TiDB

此处记录 riscv64 / SG2042 平台在 RevyOS 下的编译与性能测试过程。若使用其他发行版亦可供参考。

x86_64 环境请直接参考 TiDB 官方文档，使用官方脚本和 `tiup` 工具自动安装，或者使用发行版提供的二进制。部分步骤请见结尾 [x86_64 Notes](#x86_64-notes) 章节。

## 测试环境

x86_64:
- OS: openEuler 23.09 x86_64
- CPU: Xeon Gold 5215L CPU @ 2.50GHz, 10*vCPU (Proxmox VE 8.0 虚拟化环境)
- RAM: 8 GiB
- TiDB 部署方式：`tiup playground`

riscv64:
- Machine: Milk-V Pioneer v1.3
- OS: RevyOS 20240327, 已开启 `c910v` 仓库 / T-Head 优化 GCC
    - 文档见：[RevyOS Docs](https://revyos.github.io/docs/build/debian/enable_optimization_gcc/)
- CPU: Sophgo SG2042
- RAM: 128GiB DDR4 (w/REG ECC)

## 编译环境准备

```shell
sudo apt update
sudo apt install -y cmake curl git golang gcc-12 g++-12 clang
git clone --depth=1 -b rv64 https://github.com/xhebox/tidb
git clone --depth=1 -b release-7.4 https://github.com/tikv/pd
git clone --depth=1 -b rv64 https://github.com/xhebox/tikv
```

### TiDB 编译

```shell
cd tidb
make server
```

### tikv 编译

> Note: tikv 目前依赖 nightly 版本的 Rust 编译，需要使用 rustup 安装，而非发行版提供的版本。

```shell
sudo apt install libssl-dev
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
rustup install nightly
cd tikv
export CC=gcc-12
export CXX=g++12
cargo build --no-default-features --features "portable test-engine-kv-rocksdb test-engine-raft-raft-engine" 
```

### pd 编译

```shell
cd pd
make pd-server
```

### 启动 TiDB

依次、分别开启：

```shell
cd ~
./pd/bin/pd-server
./tikv/target/debug/tikv-server
./tidb/bin/tidb-server -store tikv -path 127.0.0.1:2379
```

（tmux / 多开 SSH 等方式均可；三个服务全部开在同一台机器上。）

## 性能测试

### sysbench

```shell
curl -LO https://github.com/akopytov/sysbench/archive/refs/tags/1.0.20.tar.gz
tar xvf 1.0.20.tar.gz
cd sysbench-1.0.20
sudo apt install -y automake libtool pkg-config libaio-dev libmysqlclient-dev libssl-dev libpq-dev libck-dev
```

#### LuaJIT

sysbench 依赖 LuaJIT，而自带的版本并不支持 riscv64。此处替换为 PLCT Lab 的移植版。

```shell
rm -rf third_party/luajit/luajit
git clone https://github.com/plctlab/LuaJIT third_party/luajit/luajit
```

目前，在 SG2042 等 C906/C910 CPU 执行上需要修改源码，否则会因 LuaJIT 尝试执行 Zba/Zbb 指令报 SIGILL。

```shell
vim third_party/luajit/luajit/src/lib_jit.c
```

注释掉如下两行以禁用 Zba/Zbb：

```C
//  flags |= riscv_probe(riscv_zba, JIT_F_RVZba);
//  flags |= riscv_probe(riscv_zbb, JIT_F_RVZbb);
```

开始编译：

```shell
./autogen.sh
./configure --with-system-ck --with-mysql --with-pgsql
make -j
sudo make install
```

#### 执行测试

```shell
# Prepare
sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-db=test --tables=4 --table-size=100000 --threads=10 prepare
# Run
sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-db=test --tables=4 --table-size=100000 --threads=10 --report-interval=3  --time=60 run 2>&1 | tee sysbench.log
# Run w/64 Threads
sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-db=test --tables=4 --table-size=100000 --threads=64 --report-interval=3  --time=60 run 2>&1 | tee sysbench_64t.log
# Cleanup
sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-db=test --tables=4 --table-size=100000 --threads=10 cleanup
```

#### 测试结果

详细结果参见 [logs](./logs) 目录。

##### sysbench

性能对比

SQL statistics

| Platform            | read   | write   | other  | total  | transactions | transactions/s | queries | queries/s | ignored errors | reconnects |
|---------------------|--------|---------|--------|--------|--------------|----------------|---------|-----------|----------------|------------|
| x86_64 @ 10 Threads | 51394  | 14684   | 7342   | 73420  | 3671         | 61.01          | 73420   | 1220.16   | 0              | 0          |
| SG2042 @ 10 Threads | 59500  | 46978   | 8522   | 85000  | 4250         | 70.63          | 85000   | 1412.67   | 0              | 0          |
| SG2042 @ 64 Threads | 144886 | 41332   | 20762  | 206980 | 10349        | 171.5          | 206980  | 3430.03   | 0              | 0          |
| diff @ 10 Threads   | 15.77% | 219.93% | 16.07% | 15.77% | 15.77%       | 15.77%         | 15.77%  | 15.78%    | N/A            | N/A        |

Latency

| Platform            | min     | avg     | max     | 95th percentile | sum        |
|---------------------|---------|---------|---------|-----------------|------------|
| x86_64 @ 10 Threads | 19.13   | 163.68  | 494.14  | 292.6           | 600868.39  |
| SG2042 @ 10 Threads | 108.3   | 141.33  | 216.89  | 155.8           | 600649.19  |
| SG2042 @ 64 Threads | 240.27  | 372.11  | 607.57  | 442.73          | 3850980.52 |
| diff @ 10 Threads   | 466.13% | -13.65% | -56.11% | -46.75%         | -0.04%     |

Threads fairness

| Platform            | events avg | events stddev | execution time avg | execution time stddev |
|---------------------|------------|---------------|--------------------|-----------------------|
| x86_64 @ 10 Threads | 367.1      | 3.96          | 60.0868            | 0.05                  |
| SG2042 @ 10 Threads | 425        | 1.1           | 60.0649            | 0.04                  |
| SG2042 @ 64 Threads | 161.7031   | 1.41          | 60.1716            | 0.08                  |
| diff @ 10T          | 15.77%     | -72.22%       | -0.04%             | -20.00%               |

Raw data / log

<details><summary>Click to expand</summary>

openEuler 23.09 x86_64, Xeon Gold 5215L CPU @ 2.50GHz, 10*vCPU (Proxmox VE 8.0)

```log
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 10
Report intermediate results every 3 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 3s ] thds: 10 tps: 84.28 qps: 1741.55 (r/w/o: 1223.22/346.44/171.89) lat (ms,95%): 207.82 err/s: 0.00 reconn/s: 0.00
[ 6s ] thds: 10 tps: 57.00 qps: 1122.32 (r/w/o: 788.32/220.00/114.00) lat (ms,95%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 9s ] thds: 10 tps: 67.01 qps: 1339.18 (r/w/o: 934.46/270.70/134.02) lat (ms,95%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 12s ] thds: 10 tps: 65.33 qps: 1318.97 (r/w/o: 925.65/262.66/130.66) lat (ms,95%): 282.25 err/s: 0.00 reconn/s: 0.00
[ 15s ] thds: 10 tps: 58.00 qps: 1146.68 (r/w/o: 800.01/230.67/116.00) lat (ms,95%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 18s ] thds: 10 tps: 56.67 qps: 1135.67 (r/w/o: 797.00/225.33/113.33) lat (ms,95%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 21s ] thds: 10 tps: 68.65 qps: 1383.38 (r/w/o: 968.80/277.28/137.31) lat (ms,95%): 244.38 err/s: 0.00 reconn/s: 0.00
[ 24s ] thds: 10 tps: 59.01 qps: 1165.21 (r/w/o: 813.81/233.37/118.02) lat (ms,95%): 337.94 err/s: 0.00 reconn/s: 0.00
[ 27s ] thds: 10 tps: 62.67 qps: 1278.37 (r/w/o: 894.69/258.34/125.34) lat (ms,95%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 10 tps: 63.00 qps: 1259.66 (r/w/o: 881.33/252.33/126.00) lat (ms,95%): 287.38 err/s: 0.00 reconn/s: 0.00
[ 33s ] thds: 10 tps: 61.48 qps: 1200.27 (r/w/o: 841.94/235.36/122.97) lat (ms,95%): 308.84 err/s: 0.00 reconn/s: 0.00
[ 36s ] thds: 10 tps: 62.17 qps: 1266.31 (r/w/o: 886.55/255.41/124.35) lat (ms,95%): 297.92 err/s: 0.00 reconn/s: 0.00
[ 39s ] thds: 10 tps: 60.00 qps: 1194.38 (r/w/o: 837.04/237.34/120.01) lat (ms,95%): 331.91 err/s: 0.00 reconn/s: 0.00
[ 42s ] thds: 10 tps: 67.35 qps: 1345.26 (r/w/o: 942.51/268.05/134.69) lat (ms,95%): 248.83 err/s: 0.00 reconn/s: 0.00
[ 45s ] thds: 10 tps: 59.67 qps: 1195.68 (r/w/o: 836.34/240.00/119.33) lat (ms,95%): 277.21 err/s: 0.00 reconn/s: 0.00
[ 48s ] thds: 10 tps: 62.33 qps: 1242.66 (r/w/o: 869.99/248.00/124.67) lat (ms,95%): 267.41 err/s: 0.00 reconn/s: 0.00
[ 51s ] thds: 10 tps: 50.66 qps: 1023.81 (r/w/o: 715.86/206.63/101.31) lat (ms,95%): 314.45 err/s: 0.00 reconn/s: 0.00
[ 54s ] thds: 10 tps: 52.01 qps: 1033.87 (r/w/o: 725.81/204.04/104.02) lat (ms,95%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 57s ] thds: 10 tps: 49.00 qps: 971.99 (r/w/o: 679.33/194.66/98.00) lat (ms,95%): 320.17 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 10 tps: 53.99 qps: 1093.76 (r/w/o: 763.16/222.62/107.98) lat (ms,95%): 277.21 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            51394
        write:                           14684
        other:                           7342
        total:                           73420
    transactions:                        3671   (61.01 per sec.)
    queries:                             73420  (1220.16 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.1712s
    total number of events:              3671

Latency (ms):
         min:                                   19.13
         avg:                                  163.68
         max:                                  494.14
         95th percentile:                      292.60
         sum:                               600868.39

Threads fairness:
    events (avg/stddev):           367.1000/3.96
    execution time (avg/stddev):   60.0868/0.05
```

RevyOS 20240327, SG2042 10T

```log
$ sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-db=test  --tables=4 --table-size=100000  --threads=10 --report-interval=3  --time=60 run 2>&1 | tee sysbench.log
sysbench 1.0.20 (using bundled LuaJIT 2.1.1710235524)

Running the test with following options:
Number of threads: 10
Report intermediate results every 3 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 3s ] thds: 10 tps: 64.67 qps: 1332.23 (r/w/o: 939.26/260.01/132.96) lat (ms,95%): 173.58 err/s: 0.00 reconn/s: 0.00
[ 6s ] thds: 10 tps: 73.17 qps: 1464.79 (r/w/o: 1024.41/293.70/146.68) lat (ms,95%): 147.61 err/s: 0.00 reconn/s: 0.00
[ 9s ] thds: 10 tps: 71.66 qps: 1429.52 (r/w/o: 1000.23/285.97/143.32) lat (ms,95%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 12s ] thds: 10 tps: 71.06 qps: 1427.11 (r/w/o: 1001.78/281.89/143.44) lat (ms,95%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 15s ] thds: 10 tps: 73.65 qps: 1473.29 (r/w/o: 1031.07/294.93/147.30) lat (ms,95%): 142.39 err/s: 0.00 reconn/s: 0.00
[ 18s ] thds: 10 tps: 74.01 qps: 1476.47 (r/w/o: 1033.76/294.69/148.01) lat (ms,95%): 147.61 err/s: 0.00 reconn/s: 0.00
[ 21s ] thds: 10 tps: 73.34 qps: 1462.70 (r/w/o: 1022.03/294.01/146.67) lat (ms,95%): 144.97 err/s: 0.00 reconn/s: 0.00
[ 24s ] thds: 10 tps: 70.63 qps: 1418.98 (r/w/o: 992.19/285.53/141.27) lat (ms,95%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 27s ] thds: 10 tps: 71.03 qps: 1425.17 (r/w/o: 1000.35/281.77/143.05) lat (ms,95%): 150.29 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 10 tps: 70.60 qps: 1405.91 (r/w/o: 983.00/281.05/141.86) lat (ms,95%): 153.02 err/s: 0.00 reconn/s: 0.00
[ 33s ] thds: 10 tps: 70.34 qps: 1414.76 (r/w/o: 990.07/283.35/141.34) lat (ms,95%): 153.02 err/s: 0.00 reconn/s: 0.00
[ 36s ] thds: 10 tps: 70.71 qps: 1403.50 (r/w/o: 980.92/280.83/141.74) lat (ms,95%): 153.02 err/s: 0.00 reconn/s: 0.00
[ 39s ] thds: 10 tps: 69.10 qps: 1385.98 (r/w/o: 974.41/272.37/139.20) lat (ms,95%): 164.45 err/s: 0.00 reconn/s: 0.00
[ 42s ] thds: 10 tps: 68.60 qps: 1377.76 (r/w/o: 960.80/279.08/137.88) lat (ms,95%): 158.63 err/s: 0.00 reconn/s: 0.00
[ 45s ] thds: 10 tps: 70.69 qps: 1408.20 (r/w/o: 988.04/278.44/141.72) lat (ms,95%): 153.02 err/s: 0.00 reconn/s: 0.00
[ 48s ] thds: 10 tps: 69.93 qps: 1399.70 (r/w/o: 978.76/281.07/139.87) lat (ms,95%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 51s ] thds: 10 tps: 69.71 qps: 1393.28 (r/w/o: 975.00/278.52/139.76) lat (ms,95%): 155.80 err/s: 0.00 reconn/s: 0.00
[ 54s ] thds: 10 tps: 68.30 qps: 1356.66 (r/w/o: 947.86/272.20/136.60) lat (ms,95%): 170.48 err/s: 0.00 reconn/s: 0.00
[ 57s ] thds: 10 tps: 71.41 qps: 1430.10 (r/w/o: 1003.34/283.62/143.14) lat (ms,95%): 150.29 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 10 tps: 70.30 qps: 1411.01 (r/w/o: 987.87/282.54/140.60) lat (ms,95%): 155.80 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            59500
        write:                           16978
        other:                           8522
        total:                           85000
    transactions:                        4250   (70.63 per sec.)
    queries:                             85000  (1412.67 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.1498s
    total number of events:              4250

Latency (ms):
         min:                                  108.30
         avg:                                  141.33
         max:                                  216.89
         95th percentile:                      155.80
         sum:                               600649.19

Threads fairness:
    events (avg/stddev):           425.0000/1.10
    execution time (avg/stddev):   60.0649/0.04

debian@revyos-pioneer:~$ 
```

SG2042 64T

```log
$ sysbench /usr/local/share/sysbench/oltp_read_write.lua --mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-db=test  --tables=4 --table-size=100000  --threads=64 --report-interval=3  --time=60 run 2>&1 | tee sysbench_64t.log
sysbench 1.0.20 (using bundled LuaJIT 2.1.1710235524)

Running the test with following options:
Number of threads: 64
Report intermediate results every 3 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 3s ] thds: 64 tps: 157.16 qps: 3384.71 (r/w/o: 2404.34/644.39/335.98) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 6s ] thds: 64 tps: 169.23 qps: 3391.94 (r/w/o: 2377.92/674.56/339.46) lat (ms,95%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 9s ] thds: 64 tps: 176.19 qps: 3501.24 (r/w/o: 2446.40/700.78/354.05) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 12s ] thds: 64 tps: 170.96 qps: 3409.96 (r/w/o: 2386.84/680.53/342.60) lat (ms,95%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 15s ] thds: 64 tps: 162.11 qps: 3253.50 (r/w/o: 2279.52/648.44/325.55) lat (ms,95%): 539.71 err/s: 0.00 reconn/s: 0.00
[ 18s ] thds: 64 tps: 174.37 qps: 3521.72 (r/w/o: 2464.84/706.81/350.07) lat (ms,95%): 419.45 err/s: 0.00 reconn/s: 0.00
[ 21s ] thds: 64 tps: 172.50 qps: 3407.39 (r/w/o: 2379.03/681.68/346.68) lat (ms,95%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 24s ] thds: 64 tps: 167.06 qps: 3380.91 (r/w/o: 2375.21/670.58/335.12) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 27s ] thds: 64 tps: 174.05 qps: 3462.03 (r/w/o: 2422.72/690.87/348.44) lat (ms,95%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 64 tps: 172.63 qps: 3454.23 (r/w/o: 2412.46/695.85/345.92) lat (ms,95%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 33s ] thds: 64 tps: 174.52 qps: 3479.74 (r/w/o: 2440.96/689.41/349.38) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 36s ] thds: 64 tps: 171.67 qps: 3433.04 (r/w/o: 2402.70/686.01/344.34) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 39s ] thds: 64 tps: 173.55 qps: 3453.95 (r/w/o: 2416.33/689.52/348.09) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 42s ] thds: 64 tps: 174.25 qps: 3508.04 (r/w/o: 2453.86/705.67/348.50) lat (ms,95%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 45s ] thds: 64 tps: 172.35 qps: 3459.96 (r/w/o: 2425.54/688.73/345.70) lat (ms,95%): 442.73 err/s: 0.00 reconn/s: 0.00
[ 48s ] thds: 64 tps: 178.54 qps: 3544.41 (r/w/o: 2480.52/705.48/358.41) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
[ 51s ] thds: 64 tps: 166.99 qps: 3332.88 (r/w/o: 2333.92/663.64/335.32) lat (ms,95%): 475.79 err/s: 0.00 reconn/s: 0.00
[ 54s ] thds: 64 tps: 174.71 qps: 3491.59 (r/w/o: 2439.65/701.18/350.76) lat (ms,95%): 427.07 err/s: 0.00 reconn/s: 0.00
[ 57s ] thds: 64 tps: 168.68 qps: 3387.31 (r/w/o: 2371.22/676.73/339.36) lat (ms,95%): 450.77 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 64 tps: 175.27 qps: 3503.36 (r/w/o: 2453.75/697.41/352.20) lat (ms,95%): 434.83 err/s: 0.00 reconn/s: 0.00
SQL statistics:
    queries performed:
        read:                            144886
        write:                           41332
        other:                           20762
        total:                           206980
    transactions:                        10349  (171.50 per sec.)
    queries:                             206980 (3430.03 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.3230s
    total number of events:              10349

Latency (ms):
         min:                                  240.27
         avg:                                  372.11
         max:                                  607.57
         95th percentile:                      442.73
         sum:                              3850980.52

Threads fairness:
    events (avg/stddev):           161.7031/1.41
    execution time (avg/stddev):   60.1716/0.08
```

</details>



### go-tpc / TPC-C

```shell
git clone --depth=1 https://github.com/pingcap/go-tpc
cd go-tpc
vim Makefile # 替换第一行的 amd64 为 riscv64
make build
cd bin
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 4 --threads 10 prepare
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 4 --threads 10 check
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 4 --threads 10 --time 10m run
# 64 Threads
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 4 --threads 64 --time 10m run
# warehouses=500 注意此参数下生成/导入数据需要花费很长时间，12h 起步
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 500 --threads 64 prepare
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 500 --threads 64 check
./go-tpc tpcc -H localhost -P 4000 -D tpcc --warehouses 500 --threads 64 --time 10m run
```

#### 测试结果

性能概览

openEuler 23.09 x86_64, Xeon Gold 5215L CPU @ 2.50GHz, 10*vCPU (Proxmox VE 8.0 Virt)

| Summary     | DELIVERY | NEW_ORDER | ORDER_STATUS | PAYMENT   | STOCK_LEVEL |
|-------------|----------|-----------|--------------|-----------|-------------|
| Takes (s)   | 599.7    | 599.9     | 599.8        | 599.9     | 599.8       |
| Count       | 1377     | 15770     | 1347         | 15135     | 1444        |
| TPM         | 137.8    | 1577.2    | 134.7        | 1513.7    | 144.4       |
| Sum (ms)    | 247717.2 | 2285792.7 | 8229.1       | 3414811.8 | 36433.4     |
| Avg (ms)    | 180.0    | 145.0     | 6.1          | 225.7     | 25.2        |
| 50th (ms)   | 176.2    | 117.4     | 6.3          | 184.5     | 8.4         |
| 90th (ms)   | 260.0    | 260.0     | 7.9          | 469.8     | 79.7        |
| 95th (ms)   | 302.0    | 352.3     | 7.9          | 570.4     | 104.9       |
| 99th (ms)   | 402.7    | 604.0     | 9.4          | 771.8     | 167.8       |
| 99.9th (ms) | 604.0    | 872.4     | 58.7         | 1073.7    | 226.5       |
| Max (ms)    | 671.1    | 1208.0    | 67.1         | 1610.6    | 251.7       |

RevyOS, SG2042 @ 10T

| Summary     | DELIVERY | NEW_ORDER | ORDER_STATUS | PAYMENT   | STOCK_LEVEL |
|-------------|----------|-----------|--------------|-----------|-------------|
| Takes (s)   | 599.6    | 599.9     | 599.8        | 599.9     | 599.6       |
| Count       | 1919     | 22643     | 2128         | 21590     | 1952        |
| TPM         | 192.0    | 2264.6    | 212.9        | 2159.2    | 195.3       |
| Sum (ms)    | 916801.5 | 2583881.8 | 250127.1     | 1973698.1 | 250901.8    |
| Avg (ms)    | 477.9    | 114.2     | 117.6        | 91.4      | 128.6       |
| 50th (ms)   | 419.4    | 104.9     | 92.3         | 75.5      | 130.0       |
| 90th (ms)   | 738.2    | 159.4     | 243.3        | 167.8     | 159.4       |
| 95th (ms)   | 872.4    | 192.9     | 260.0        | 192.9     | 167.8       |
| 99th (ms)   | 1208.0   | 260.0     | 302.0        | 260.0     | 201.3       |
| 99.9th (ms) | 1677.7   | 369.1     | 335.5        | 352.3     | 243.3       |
| Max (ms)    | 1677.7   | 486.5     | 385.9        | 486.5     | 260.0       |

RevyOS, SG2042 @ 64T

| Summary     | DELIVERY  | NEW_ORDER  | ORDER_STATUS | PAYMENT    | STOCK_LEVEL |
|-------------|-----------|------------|--------------|------------|-------------|
| Takes (s)   | 601.2     | 601.6      | 601.7        | 601.7      | 601.5       |
| Count       | 2642      | 30166      | 2750         | 28662      | 2646        |
| TPM         | 263.7     | 3008.5     | 274.2        | 2858.0     | 263.9       |
| Sum (ms)    | 2473834.9 | 14396279.2 | 146933.0     | 20999452.1 | 363155.8    |
| Avg (ms)    | 936.9     | 477.4      | 53.4         | 732.9      | 137.3       |
| 50th (ms)   | 738.2     | 268.4      | 46.1         | 637.5      | 134.2       |
| 90th (ms)   | 1677.7    | 1208.0     | 58.7         | 1476.4     | 176.2       |
| 95th (ms)   | 2080.4    | 1476.4     | 71.3         | 1744.8     | 201.3       |
| 99th (ms)   | 2952.8    | 1946.2     | 369.1        | 2147.5     | 234.9       |
| 99.9th (ms) | 3758.1    | 2415.9     | 570.4        | 2550.1     | 285.2       |
| Max (ms)    | 4160.7    | 2952.8     | 671.1        | 2684.4     | 352.3       |

RevyOS, SG2042 @ 64T, warehouse = 500

| Summary    | DELIVERY  | NEW_ORDER  | ORDER_STATUS | PAYMENT    | STOCK_LEVEL |
|------------|-----------|------------|--------------|------------|-------------|
| Takes(s)   | 598.6     | 599.9      | 599.8        | 599.9      | 599.5       |
| Count      | 3967      | 43974      | 3880         | 41435      | 3868        |
| TPM        | 397.6     | 4398.2     | 388.1        | 4144.2     | 387.1       |
| Sum(ms)    | 3733619.4 | 17889180.1 | 1167050.7    | 14710727.0 | 818158.8    |
| Avg(ms)    | 941.9     | 406.9      | 300.9        | 355.1      | 211.5       |
| 50th(ms)   | 939.5     | 402.7      | 268.4        | 335.5      | 201.3       |
| 90th(ms)   | 1140.9    | 520.1      | 570.4        | 453.0      | 285.2       |
| 95th(ms)   | 1208.0    | 604.0      | 604.0        | 570.4      | 335.5       |
| 99th(ms)   | 1409.3    | 872.4      | 704.6        | 906.0      | 469.8       |
| 99.9th(ms) | 1879.0    | 1208.0     | 872.4        | 1275.1     | 637.5       |
| Max(ms)    | 2281.7    | 1811.9     | 1543.5       | 1946.2     | 838.9       |

对比：

| Metric     | openEuler 23.09 x86_64 10T | RevyOS SG2042 10T | RevyOS SG2042 64T | RevyOS SG2042 64T, warehouses=500 |
|------------|----------------------------|-------------------|-------------------|----------------------------------|
| tpmC       | 1577.2                     | 2264.6            | 3008.5            | 4398.2                           |
| tpmTotal   | 3507.9                     | 5024.0            | 6668.4            | 9715.3                           |
| Efficiency | 3066.2%                    | 4402.4%           | 5848.6%           | 68.4%                            |

Raw data / log

<details><summary>Click to expand</summary>


openEuler 23.09 x86_64, Xeon Gold 5215L CPU @ 2.50GHz, 10*vCPU (in Proxmox VE 8.0)

```log
Finished
[Summary] DELIVERY - Takes(s): 599.7, Count: 1377, TPM: 137.8, Sum(ms): 247717.2, Avg(ms): 180.0, 50th(ms): 176.2, 90th(ms): 260.0, 95th(ms): 302.0, 99th(ms): 402.7, 99.9th(ms): 604.0, Max(ms): 671.1
[Summary] NEW_ORDER - Takes(s): 599.9, Count: 15770, TPM: 1577.2, Sum(ms): 2285792.7, Avg(ms): 145.0, 50th(ms): 117.4, 90th(ms): 260.0, 95th(ms): 352.3, 99th(ms): 604.0, 99.9th(ms): 872.4, Max(ms): 1208.0
[Summary] NEW_ORDER_ERR - Takes(s): 599.9, Count: 4, TPM: 0.4, Sum(ms): 207.6, Avg(ms): 52.8, 50th(ms): 52.4, 90th(ms): 88.1, 95th(ms): 88.1, 99th(ms): 88.1, 99.9th(ms): 88.1, Max(ms): 88.1
[Summary] ORDER_STATUS - Takes(s): 599.8, Count: 1347, TPM: 134.7, Sum(ms): 8229.1, Avg(ms): 6.1, 50th(ms): 6.3, 90th(ms): 7.9, 95th(ms): 7.9, 99th(ms): 9.4, 99.9th(ms): 58.7, Max(ms): 67.1
[Summary] PAYMENT - Takes(s): 599.9, Count: 15135, TPM: 1513.7, Sum(ms): 3414811.8, Avg(ms): 225.7, 50th(ms): 184.5, 90th(ms): 469.8, 95th(ms): 570.4, 99th(ms): 771.8, 99.9th(ms): 1073.7, Max(ms): 1610.6
[Summary] PAYMENT_ERR - Takes(s): 599.9, Count: 5, TPM: 0.5, Sum(ms): 1341.0, Avg(ms): 266.1, 50th(ms): 302.0, 90th(ms): 503.3, 95th(ms): 503.3, 99th(ms): 503.3, 99.9th(ms): 503.3, Max(ms): 503.3
[Summary] STOCK_LEVEL - Takes(s): 599.8, Count: 1444, TPM: 144.4, Sum(ms): 36433.4, Avg(ms): 25.2, 50th(ms): 8.4, 90th(ms): 79.7, 95th(ms): 104.9, 99th(ms): 167.8, 99.9th(ms): 226.5, Max(ms): 251.7
tpmC: 1577.2, tpmTotal: 3507.9, efficiency: 3066.2%
```

RevyOS SG2042 10T

```log
[Summary] DELIVERY - Takes(s): 599.6, Count: 1919, TPM: 192.0, Sum(ms): 916801.5, Avg(ms): 477.9, 50th(ms): 419.4, 90th(ms): 738.2, 95th(ms): 872.4, 99th(ms): 1208.0, 99.9th(ms): 1677.7, Max(ms): 1677.7
[Summary] NEW_ORDER - Takes(s): 599.9, Count: 22643, TPM: 2264.6, Sum(ms): 2583881.8, Avg(ms): 114.2, 50th(ms): 104.9, 90th(ms): 159.4, 95th(ms): 192.9, 99th(ms): 260.0, 99.9th(ms): 369.1, Max(ms): 486.5
[Summary] ORDER_STATUS - Takes(s): 599.8, Count: 2128, TPM: 212.9, Sum(ms): 250127.1, Avg(ms): 117.6, 50th(ms): 92.3, 90th(ms): 243.3, 95th(ms): 260.0, 99th(ms): 302.0, 99.9th(ms): 335.5, Max(ms): 385.9
[Summary] PAYMENT - Takes(s): 599.9, Count: 21590, TPM: 2159.2, Sum(ms): 1973698.1, Avg(ms): 91.4, 50th(ms): 75.5, 90th(ms): 167.8, 95th(ms): 192.9, 99th(ms): 260.0, 99.9th(ms): 352.3, Max(ms): 486.5
[Summary] STOCK_LEVEL - Takes(s): 599.6, Count: 1952, TPM: 195.3, Sum(ms): 250901.8, Avg(ms): 128.6, 50th(ms): 130.0, 90th(ms): 159.4, 95th(ms): 167.8, 99th(ms): 201.3, 99.9th(ms): 243.3, Max(ms): 260.0
tpmC: 2264.6, tpmTotal: 5024.0, efficiency: 4402.4%
```

RevyOS SG2042 64T

```log
[Summary] DELIVERY - Takes(s): 601.2, Count: 2642, TPM: 263.7, Sum(ms): 2473834.9, Avg(ms): 936.9, 50th(ms): 738.2, 90th(ms): 1677.7, 95th(ms): 2080.4, 99th(ms): 2952.8, 99.9th(ms): 3758.1, Max(ms): 4160.7
[Summary] NEW_ORDER - Takes(s): 601.6, Count: 30166, TPM: 3008.5, Sum(ms): 14396279.2, Avg(ms): 477.4, 50th(ms): 268.4, 90th(ms): 1208.0, 95th(ms): 1476.4, 99th(ms): 1946.2, 99.9th(ms): 2415.9, Max(ms): 2952.8
[Summary] ORDER_STATUS - Takes(s): 601.7, Count: 2750, TPM: 274.2, Sum(ms): 146933.0, Avg(ms): 53.4, 50th(ms): 46.1, 90th(ms): 58.7, 95th(ms): 71.3, 99th(ms): 369.1, 99.9th(ms): 570.4, Max(ms): 671.1
[Summary] PAYMENT - Takes(s): 601.7, Count: 28662, TPM: 2858.0, Sum(ms): 20999452.1, Avg(ms): 732.9, 50th(ms): 637.5, 90th(ms): 1476.4, 95th(ms): 1744.8, 99th(ms): 2147.5, 99.9th(ms): 2550.1, Max(ms): 2684.4
[Summary] STOCK_LEVEL - Takes(s): 601.5, Count: 2646, TPM: 263.9, Sum(ms): 363155.8, Avg(ms): 137.3, 50th(ms): 134.2, 90th(ms): 176.2, 95th(ms): 201.3, 99th(ms): 234.9, 99.9th(ms): 285.2, Max(ms): 352.3
tpmC: 3008.5, tpmTotal: 6668.4, efficiency: 5848.6%
```

RevyOS SG2042 64T, warehouses=500

```log
[Summary] DELIVERY - Takes(s): 598.6, Count: 3967, TPM: 397.6, Sum(ms): 3733619.4, Avg(ms): 941.9, 50th(ms): 939.5, 90th(ms): 1140.9, 95th(ms): 1208.0, 99th(ms): 1409.3, 99.9th(ms): 1879.0, Max(ms): 2281.7
[Summary] NEW_ORDER - Takes(s): 599.9, Count: 43974, TPM: 4398.2, Sum(ms): 17889180.1, Avg(ms): 406.9, 50th(ms): 402.7, 90th(ms): 520.1, 95th(ms): 604.0, 99th(ms): 872.4, 99.9th(ms): 1208.0, Max(ms): 1811.9
[Summary] ORDER_STATUS - Takes(s): 599.8, Count: 3880, TPM: 388.1, Sum(ms): 1167050.7, Avg(ms): 300.9, 50th(ms): 268.4, 90th(ms): 570.4, 95th(ms): 604.0, 99th(ms): 704.6, 99.9th(ms): 872.4, Max(ms): 1543.5
[Summary] PAYMENT - Takes(s): 599.9, Count: 41435, TPM: 4144.2, Sum(ms): 14710727.0, Avg(ms): 355.1, 50th(ms): 335.5, 90th(ms): 453.0, 95th(ms): 570.4, 99th(ms): 906.0, 99.9th(ms): 1275.1, Max(ms): 1946.2
[Summary] STOCK_LEVEL - Takes(s): 599.5, Count: 3868, TPM: 387.1, Sum(ms): 818158.8, Avg(ms): 211.5, 50th(ms): 201.3, 90th(ms): 285.2, 95th(ms): 335.5, 99th(ms): 469.8, 99.9th(ms): 637.5, Max(ms): 838.9
tpmC: 4398.2, tpmTotal: 9715.3, efficiency: 68.4%
```

</details>

### x86_64 Notes

#### sysbench

```shell
sudo dnf install -y sysbench luajit
sysbench /usr/share/sysbench/oltp_read_write.lua \
    --mysql-host=127.0.0.1 \
    --mysql-port=4000 \
    --mysql-user=root \
    --mysql-db=test \
    --tables=4 \
    --table-size=100000 \
    --threads=10 \
    --report-interval=3 \
    --time=60 run 2>&1 | tee sysbench.log
```

#### TPC-C

```shell
tiup bench tpcc -H 127.0.0.1 -P 4000 -D tpcc --warehouses 4 prepare -T 10
tiup bench tpcc -H localhost -P 4000 -D tpcc --warehouses 4 check
tiup bench tpcc -H localhost -P 4000 -D tpcc --warehouses 4 --threads 10 --time 10m run 2>&1 | tee tpcc_result.log
```

### In case you're not on RevyOS...

e.g. Fedora, openEuler, etc.

Fedora riscv64 目前似乎并不提供 tidb 编译所依赖的 GCC 12 版本，可以考虑使用 chroot 等方式换其他提供了 GCC 12 的发行版的 rootfs，比如 Arch RISC-V。以下步骤仅供参考。

此外，在使用 gvm 进行 Go 版本管理前依旧需要安装一个 Go，版本 1.4 以上。通常使用发行版包管理器提供的版本即可。

#### gvm / Golang 1.21 setup

```shell
sudo dnf install -y bison golang
curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | sh
TIDB_GOVERSION=$(curl -s -S -L https://github.com/pingcap/tidb/blob/master/go.mod | grep -Eo "\"go [[:digit:]]+.[[:digit:]]+\"" | grep -Eo "[[:digit:]]+.[[:digit:]]+")
gvm install go${TIDB_GOVERSION}
gvm use go${TIDB_GOVERSION} --default
cd ~/tidb && make server
cd ~/pd && make pd-server
```

### 已知问题

时间所限，笔者暂时没有找到合适的测试机，文中所使用的 openEuler x86_64 机器运行在 HDD 上，I/O 性能会有严重瓶颈。这可能会影响 TiDB 的性能表现。

x86_64 机器运行在 PVE 虚拟化环境下。通常来说，KVM 虚拟化会有性能损失，但不会很大。这也可能会影响性能表现。

此外，内存大小不同也可能影响性能。

`tikv`, `pd-server`, `tidb` 的日志输出均为默认的 `INFO` 级别，这可能会影响性能。