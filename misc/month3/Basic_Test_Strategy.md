##### 修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者    |
|-----------|----------|------------|--------|---------|
| 2023-7-11 | 0.1      |            | 初稿     | KevinMX |

# openEuler 23.03 RISC-V 测试策略

## 摘要

openEuler 是一款开源操作系统。当前 openEuler 内核源于 Linux，支持多种处理器架构，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。

openEuler RISC-V 广泛支持国内外 RISC-V 架构处理器，适配全志 D1、Sipeed LicheeRV、HiFive Unmatched、StarFive VisionFive 等多款开发板。

本文主要描述 openEuler 23.03 RISC-V 版本的测试策略，用于指导后续测试工作的开展。

## 测试环境

系统：openEuler RISC-V 23.03 preview, [base 镜像](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.03-V1-riscv64/QEMU/openEuler-23.03-V1-base-qemu-preview.qcow2.zst) + [默认启动脚本](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.03-V1-riscv64/QEMU/start_vm.sh)，脚本中添加 `-cpu rv64,sv39=on`

[xfce 镜像](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.03-V1-riscv64/QEMU/openEuler-23.03-V1-xfce-qemu-preview.qcow2.zst) 和 [xfce 启动脚本](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.03-V1-riscv64/QEMU/start_vm_xfce.sh) 供测试 xfce 使用；其他桌面环境测试/需要 GUI 的测试也可使用 xfce 启动脚本。同样推荐使用 QEMU ≥ 8.0 并在脚本中添加 `-cpu rv64,sv39=on`。

QEMU 版本：要求 ≥8.0，推荐最新版（截止此文档编写时，最新发布版本为 8.0.3）；如宿主机发行版提供的 QEMU 不满足要求，请参考 [QEMU 官方文档](https://wiki.qemu.org/Hosts/Linux) 自行编译安装最新版。

软件源：镜像默认

CPU 核心数：启动脚本默认（8）

内存大小：除非另有说明，采用镜像默认（4G）

---

## 已知缺陷 / 风险列表

| ID                                                         | 缺陷内容                                                    | 状态 |
|------------------------------------------------------------|-----------------------------------------------------------|------|
| [I7II91](https://gitee.com/openeuler/RISC-V/issues/I7II91) | 23.03 QEMU LTP 内核测试有失败项                             | Open |
| [I7IIBH](https://gitee.com/openeuler/RISC-V/issues/I7IIBH) | 23.03 QEMU trinity 内核测试不通过                           | Open |
| [I7IIDI](https://gitee.com/openeuler/RISC-V/issues/I7IIDI) | 23.03 QEMU LTP Stress 长稳测试不通过                        | Open |
| [I7IIR5](https://gitee.com/openeuler/RISC-V/issues/I7IIR5) | 23.03 QEMU csmith 和 yarpgen 编译器测试耗时过久             | Open |
| [I70JPM](https://gitee.com/openeuler/RISC-V/issues/I70JPM) | 使用 D1 SoC 的开发板上 fio 无法正常运行                     | Open |
|                                                            | A-Ops 无法启动（依赖缺失）                                    |      |
| [I6R8CR](https://gitee.com/openeuler/RISC-V/issues/I6R8CR) | A-Tune 无法启动                                             | Open |
| [I722L5](https://gitee.com/openeuler/RISC-V/issues/I722L5) | A-tuned 启动失败（golang plugin 机制 支持 riscv 有缺陷）      | Open |
| [I6V7C0](https://gitee.com/openeuler/RISC-V/issues/I6V7C0) | etmem 无法使用                                              | Open |
| [I6TI4U](https://gitee.com/openeuler/RISC-V/issues/I6TI4U) | licheePi rv dock 启动 chromium 无法显示                     | Open |
| [I6TH5M](https://gitee.com/openeuler/RISC-V/issues/I6TH5M) | unmatched 使用 lightdm 启动 GNOME 报错                      | Open |
| [I6TH5H](https://gitee.com/openeuler/RISC-V/issues/I6TH5H) | unmatched gdm 报错                                          | Open |
| [I6TH5E](https://gitee.com/openeuler/RISC-V/issues/I6TH5E) | unmatched 打开 firefox 卡死                                 | Open |
| [I6TMB6](https://gitee.com/openeuler/RISC-V/issues/I6TMB6) | Allwinner D1 Nezha 启动 firefox 失败：Illegal instruction    | Open |
| [I6TVV6](https://gitee.com/openeuler/RISC-V/issues/I6TVV6) | kubekey部署 KubeSphere 集群失败                             | Open |
| [I6TFXV](https://gitee.com/openeuler/RISC-V/issues/I6TFXV) | vision five安装ukui桌面，进入桌面，两个画面循环显示           | Open |
| [I6RR83](https://gitee.com/openeuler/RISC-V/issues/I6RR83) | pkgship安装elasticsearch失败                                | Open |
| [I6RR6R](https://gitee.com/openeuler/RISC-V/issues/I6RR6R) | pkgship服务启动失败                                         | Open |
| [I6R07N](https://gitee.com/openeuler/RISC-V/issues/I6R07N) | secpaver 无法使用                                           | Open |
| [I6QVV6](https://gitee.com/openeuler/RISC-V/issues/I6QVV6) | cinnamon 默认文件系统无法使用                               | Open |
| [I6QV8A](https://gitee.com/openeuler/RISC-V/issues/I6QV8A) | cinnamon 的 panel 中固定的软件无法打开                      | Open |
| [I6QUT1](https://gitee.com/openeuler/RISC-V/issues/I6QUT1) | cinnamon 左下角 menu 部分图标点击无反应                     | Open |
| [I6QV1V](https://gitee.com/openeuler/RISC-V/issues/I6QV1V) | cinnamon 无法使用回收站                                     | Open |
| [I6QRDS](https://gitee.com/openeuler/RISC-V/issues/I6QRDS) | 23.02-V1-xfce 在 unmatched 黑屏                             | Open |
| [I6STA0](https://gitee.com/openeuler/RISC-V/issues/I6STA0) | licheePI rv dock 无法启动 libreoffice                       | Open |
| [I6OZ5N](https://gitee.com/openeuler/RISC-V/issues/I6OZ5N) | Kiran桌面关机时的异常行为                                   | Open |
| [I6OYL4](https://gitee.com/openeuler/RISC-V/issues/I6OYL4) | 在桌面环境中打开 FFADO Mixer 提示无法与 FFADO DBUS 进行通信 | Open |
| [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY) | gnome 缺陷：gnome-control-center 启动报错                    | Open |
| [I7FQJV](https://gitee.com/openeuler/RISC-V/issues/I7FQJV) | 23.03 oncn-bwm 无法开启带宽管理                             | Open |

## 测试分层策略


## 专项测试策略

### 1. 内核测试

#### 1.1 LTP / Linux Test Project

LTP 测试套件包含一组用于测试 Linux 内核和相关功能的工具。我们的目标是通过将测试自动化引入测试工作来改进 Linux 内核和系统库。

使用 Linux Test Project（简称 LTP）对内核进行测试。本次测试使用的 LTP 版本为 [20230516](https://github.com/linux-test-project/ltp/releases/tag/20230516)。

##### 测试方法

###### 准备两个测试用虚拟盘

在宿主机：

```bash
qemu-img create -f qcow2 ext2g.qcow2 2G
qemu-img create -f qcow2 ext1g.qcow2 1G
```

同时，在 QEMU 命令行中增加以下参数：

```bash
  -drive file=ext2g.qcow2,format=qcow2,id=hd1 \
  -drive file=ext1g.qcow2,format=qcow2,id=hd2 \
  -device virtio-blk-device,drive=hd1 \
  -device virtio-blk-device,drive=hd2 \
```

###### 安装测试所需的工具

```bash
dnf install gcc git make pkgconf autoconf automake bison flex m4 kernel-tools kernel-headers kernel-devel glibc-headers openssl-devel libacl-devel libaio-devel libcap-devel ethtool expect-devel xfsprogs-devel btrfs-progs quota nfs-utils libmnl-devel libtirpc-devel
```

###### 对新硬盘分区

在虚拟机，将其各分为一个区，格式化为 ext4：

```bash
fdisk /dev/vdb
mkfs.ext4 /dev/vdb1
fdisk /dev/vdc
mkfs.ext4 /dev/vdc1
```

###### 去除内存限制

删去 `/boot/extlinux/extlinux.conf` 中的 `mem=4096M` 。

###### 重新启动

运行 `reboot` 重新启动虚拟机。

###### 下载、编译、安装 LTP

```bash
wget https://github.com/linux-test-project/ltp/releases/download/20230516/ltp-full-20230516.tar.xz
tar -xvf ltp-full-20230516.tar.xz
cd ltp-full-20230516
make autotools
./configure --with-bash --with-expect --with-perl --with-python
make
make install
```

###### 运行测试

为防止测试超时错误，增大超时限制的倍数。

```bash
# export LTP_TIMEOUT_MUL=10
```

测试的临时文件目录默认是 `/tmp`，但 openEuler 已将其安装为 tmpfs，这会导致很多测试意外失败。因此专门建立一个目录，并在运行脚本参数中指明。

```bash
mkdir -p /ltp/tmp
```

运行：

```bash
# cd /opt/ltp
# ./runltp -p -o tests.output -d /ltp/tmp -b /dev/vdc1 -B ext4 -z /dev/vdb1 -Z ext4
```

#### 1.2 trinity: syscall fuzzer

Trinity 是对内核 API 进行冒烟测试的套件。

##### 测试步骤

- 从 [GitHub 仓库](https://github.com/kernelslacker/trinity) 获取 Trinity 源代码。以非 root 用户使用 `./configure && make -j$(nproc)` 进行编译。
- 使用 `./trinity` 运行测试。如需减少日志输出，节省硬盘空间，可添加 `-q`` 或 `-qq`` 参数：`./trinity -qq`
- 运行结束后进入 `tmp` 目录查看日志。其中，`trinity.log` 为主进程的日志，`trinity-child*.log` 为各子进程的日志。trinity 检测到内核状态异常（如被 tainted）时会自动终止测试。

### 2. 基础性能测试

#### 2.1 unixbench

UnixBench 是一个类 UNIX 系统下的开源性能测试工具，被广泛用于测试 Linux 系统主机的综合性能，测试结果不仅依赖硬件配置（CPU/内存/硬盘），还取决于操作系统、库甚至编译器的差异。既可以评估单进程性能，也可以评估多进程性能。

##### 测试步骤

执行：

```bash
git clone https://github.com/kdlucas/byte-unixbench
cd byte-unixbench/UnixBench
make -j$(nproc)
./Run -c $(nproc)
```

#### 2.2 netperf

Netperf 是一种网络性能测试工具，主要基于 TCP 或 UDP 的传输。Netperf 根据应用的不同，可以进行不同模式的网络性能测试，即批量数据传输（bulk data transfer）模式和请求/应答（request/reponse）模式。可以测量 TCP 和 UDP 传输的吞吐量、时延、CPU 占用率等性能参数。Netperf 测试结果所反映的是一个系统能够以多快的速度向另一个系统发送数据，以及另一个系统能够以多快的速度接收数据。

##### 测试步骤

###### 连接两台 Qemu 测试机

参见 [适用于 Qemu 多节点的 VDE 网络配置指南](https://github.com/ArielHeleneto/Work-PLCT/blob/master/openMPI/VDE-network.md)。

并确定两台 Qemu 测试机的 IP 地址。

###### 准备环境

从软件源安装 `netperf`。

```bash
dnf install netperf -y
```

由下列命令确定包版本。

```bash
dnf info netperf
```

###### 准备服务器

在服务器中运行下列指令启动服务器。

```bash
netserver
```

###### 启动测试

将下列脚本保存到 `1.sh`

```bash
#!/bin/bash
host_ip=$1
for i in 1 64 128 256 512 1024 1500 2048 4096 9000 16384 32768 65536;do
./netperf -t TCP_STREAM -H $host_ip -l 60 -- -m $i
done
for i in 1 64 128 256 512 1024 1500 2048 4096 9000 16384 32768;do
./netperf -t UDP_STREAM -H $host_ip -l 60 -- -m $i -R 1
done
./netperf -t TCP_RR -H $host_ip
./netperf -t TCP_CRR -H $host_ip
./netperf -t UDP_RR -H $host_ip
```

并运行之。

```bash
bash 1.sh {Server-IP}
```

替换 `{Server-IP}` 为服务器 IP。从标准输出中获得测试结果。

#### 2.3、libmicro

衡量各自系统调用和lib库调用的性能，选择了259个常用的系统调用来评测操作系统系统调用方面的性能。

##### 测试步骤

```bash
wget https://codeload.github.com/redhat-performance/libMicro/zip/0.4.0-rh
unzip 0.4.0-rh
cd libMicro-0.4.0-rh
make CFLAGS=-static CC=${CROSS_COMPILE}gcc ARCH=${ARCH} -j$(nproc)
sh bench.sh
```

#### 2.4、fio

Fio是测试IOPS的工具，用来对磁盘进行压力测试和验证。磁盘IO是检查磁盘性能的重要指标，可以按照负载情况分成顺序读写、随机读写两大类。FIO是一个可以产生很多线程或进程并执行用户指定的特定类型I/O操作的工具，Fio的典型用法是编译和模拟的I/O负载匹配的作业文件。也就是说Fio是一个多线程io生成工具，可以生成多种IO模式，用来测试磁盘设备的性能（也包括文件系统：如针对网络文件系统NFS的IO测试）

1. 安装 `fio`：`sudo dnf install -y fio`

2. 创建 `fio.sh` 测试脚本，执行：

```bash
cat << 'EOF' > fio.sh
#!/bin/bash
numjobs=10
iodepth=10
mkdir test
for rw in read write randread randwrite randrw;do
for bs in 4 16 32 64 128 256 512 1024;do
if [ $rw == "randrw" ];then
fio -filename=test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -rwmixread=70 -ioengine=libaio -bs=${bs}k -size=1G -numjobs=${numjobs} -runtime=30 -group_reporting -name=job1
else
fio -filename=test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -ioengine=libaio -bs=${bs}k -size=1G -numjobs=${numjobs} -runtime=30 -group_reportin -name=job1
fi
sleep 30
done
done
EOF
```

3. 运行 `fio.sh`：`bash fio.sh`

#### 2.5、stream

stream是通过对数组的copy，scale，add，triad操作来测试CPU的内存访问带宽和浮点运算能力。Copy为最简单的操作，即从一个内存单元中读取一个数，并复制到另一个内存单元，有2次访存操作。Scale是乘法操作，从一个内存单元中读取一个数，与常数Scale相乘，得到的结果写入另一个内存单元，有2次访存。Add是加法操作，从两个内存单元中分别读取两个数，将其进行加法操作，得到的结果写入另一个内存单元中，有2次读和1次写共3次访存。Triad是前面三种的结合，先从内存中读取一个数，与scale相乘得到一个乘积，然后从一个内存单元中读取一个数与之前的乘积相加，得到的结果再写入内存，所以，有2次读和1次写共三次访存操作。

```bash
git clone https://gitee.com/thesamename/STREAM.git
cd STREAM
sudo dnf install -y gcc gfortran
sed -i "s/CC =.*/CC = gcc/" Makefile
sed -i "s/FC =.*/FC = gfortran/" Makefile
make
./stream_c.exe
```

#### 2.6、lmbench

lmbench是个用于评价系统综合性能的多平台开源benchmark，能够测试包括文档读写、内存操作、进程创建销毁开销、网络等性能，测试方法简单。

1. 安装并编译 `lmbench`：

```bash
sudo dnf install -y lmbench libtirpc libtirpc-devel
cp -R /opt/lmbench .
sudo chown -R openeuler:openeuler lmbench
wget https://git.savannah.gnu.org/cgit/config.git/plain/config.guess
cp -f config.guess lmbench/scripts/gnu-os
cd lmbench
make -j$(nproc)
```

2. 运行 `lmbench`：`make results`

3. 输入测试参数：

```
MULTIPLE COPIES[DEFAULT 1]: (默认回车)
Job placement selection[DEFAULT 1]: （默认回车）
MB[default 182159]:1024 (输入 1024)
SUBSET （ALL|HARWARE|OS|DEVELOPMENT）[default all]:(默认回车)
FASTMEM[default no]:(默认回车)
SLOWFS[default no]: (默认回车)
DISKS[default none]:(默认回车)
REMOTE[default none]: (默认回车)
Processor mhz[default 2599MHz,0.3848 nanosec clock]: (默认回车)
FSDIR[default /usr/tmp]: /usr/tmp
Status output file [default /dev/tty]: (默认回车)
Mail results [default yes]: no (设置为 no)
```

4. 等待测试完成后，查看结果：

```bash
make see
cd results && make summary > summary.out 2 > summary.errs && make percent > percent.out 2 > percent.errs
```

<!-- 安全测试暂时移除 -->

<!--

## 3. 安全测试

### 3.1. syzkaller

#### 准备编译环境

#### 获取 Golang 工具链

syzkaller 管理页面使用 Golang 编写，在构建时需要获取一份 Golang 工具链
(version >= 1.19)。

可以从 https://go.dev/dl/ 下载官方的预编译工具链并在解压后将其 bin 目录
添加到 PATH，也可以从软件包管理器直接安装

#### 制作 RISC-V 交叉编译工具链

syzkaller 需要目标平台为 RISC-V 的交叉编译工具链来编译在被测试内核上运行
的冒烟测试程序。

从 [ISCAS 镜像源](https://mirror.iscas.ac.cn/riscv-toolchains/git/riscv-collab/riscv-gnu-toolchain)
获取 RISC-V 交叉编译工具链脚本。

可以按照 [镜像源帮助文档](https://help.mirrors.cernet.edu.cn/riscv-toolchains/) 的说明下载并编译
工具链。注意预编译的工具链可能不包含 syzkaller 需要的 g++ C++ 编译器。

#### 安装 QEMU

syzkaller 需要 QEMU 为内核提供虚拟化环境。注意如果从源代码编译，需要准备
开发版本的 libslirp 包来为 QEMU 提供用户态网络虚拟化支持。

#### 构建 syzkaller

从 [GitHub 仓库](https://github.com/google/syzkaller) 获取源代码。

修改 `vm/qemu/qemu.go`，将第 455 行的 `"file=%v,if=none,format=raw,id=hd0"` 修改为
`"file=%v,if=none,format=qcow2,id=hd0"`

使用

```
make TARGETOS=linux TARGETARCH=riscv64 -j$(nproc)
```

构建 syzkaller

#### 配置受测镜像

syzkaller 实际上通过 SSH 连接到被测系统进行测试，其需要保证以下条件

- 被测系统包含网络支持
- 被测系统的内核开启了 [syzkaller 所需的调试选项](https://github.com/google/syzkaller/blob/master/docs/linux/kernel_configs.md)
- 被测系统在 /sys/kernel/debug 挂在
- 被测系统允许 root 用户通过 SSH 登陆

下载需要测试的 RISC-V 平台镜像并启动，以 root 身份登陆。

#### 配置 fstab

运行
```
echo "debugfs /sys/kernel/debugfs debugfs defaults 0 0" >> /etc/fstab
```

以自动挂载 debugfs

#### 配置 OpenSSHD

打开 `/etc/ssh/sshd_config`，确保 `PermitRootLogin`, `PasswordAuthentication`
与 `PermitEmptyPasswords` 全部设置为 `yes`.

#### 生成 SSH 密钥对

运行
```
ssh-keygen -f id_rsa -t rsa -N "" && cat id_rsa.pub >> ~/.ssh/authorized_keys
```
并将 `id_rsa` 文件拷贝到宿主机

#### 编写 syzkaller 配置文件

```
{
        "name": "riscv64",
        "target": "linux/riscv64",
        "http": ":56700",
        "workdir": ".",
        "syzkaller": ".",
        "procs": 8,
        "image": "2303.qcow2",
        "type": "qemu",
        "sshkey": "id_rsa",
        "ignores": [".*BUG: soft lockup.*", ".*rcu_sched self-detected stall on CPU.*"],
        "vm": {
                "count": 1,
                "qemu_args": "-machine virt -bios fw.bin -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-device,rng=rng0",
                "cpu": 2,
                "mem": 2048
        }
}
```

其中 `image` 的值替换为 qcow2 镜像路径，`sshkey` 替换为 `id\_rsa` 私钥路径，
`fw.bin` 替换为 `fw_payload` 固件路径。

由于 QEMU 性能较差，可能会出现内核假死报错终止测试的问题。所以添加了
`ignores` 选项来屏蔽相关的内核错误。

#### 运行测试

```
bin/syzkaller -config CONFIGURATION
```

访问本机 56700 端口即可看到测试信息统计。

### 3.2. nmap 

#### 系统环境

Host: Ubuntu 23.04 on WSL 2, Windows 10 IoT Enterprise LTSC, QEMU 8.0.0 （从源码编译）

Guest: openEuler 23.03 RISC-V preview

#### 操作步骤

> 注意：需要启动两台虚拟机，用其中一台虚拟机对另一台进行扫描。建议分别创建不同的文件夹放置两个虚拟机的磁盘镜像、启动脚本等文件。

1. 安装依赖包：`sudo apt install -y vde2`

2. 利用脚本配置 VDE 网络：

```bash
cat << 'EOF' > vde.sh
#!/bin/sh

vdeSocket=/tmp/vde.ctl
mgmtSocket=/tmp/mgmt

rm -rf $vdeSocket
rm -rf $mgmtSocket

# Check for vde tools

if ! [ -f /usr/bin/vde_switch ]
then
	echo "VDE tools not found."
	exit 1
fi

vde_switch -d -s $vdeSocket -M $mgmtSocket
slirpvde -d -s $vdeSocket -dhcp

echo "VDE socket is $vdeSocket, management socket is $mgmtSocket"
EOF
bash vde.sh
```

3. 修改两台虚拟机的启动脚本 `start_vm.sh`，完整脚本如下。

> 注意：将两台虚拟机的 `ssh_port` 修改为不同端口以免冲突。

```bash
#!/usr/bin/env bash

# The script is created for starting a riscv64 qemu virtual machine with specific parameters.

RESTORE=$(echo -en '\001\033[0m\002')
YELLOW=$(echo -en '\001\033[00;33m\002')

## Configuration
vcpu=8
memory=8
memory_append=`expr $memory \* 1024`
drive="$(ls *.qcow2)"
fw="fw_payload_oe_uboot_2304.bin"
ssh_port=12055
macadd=$(echo $RANDOM|md5sum|sed 's/../&:/g'|cut -c 1-17)

cmd="qemu-system-riscv64 \
  -nographic -machine virt \
  -smp "$vcpu" -m "$memory"G \
  -bios "$fw" \
  -drive file="$drive",format=qcow2,id=hd0 \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-vga \
  -device virtio-rng-device,rng=rng0 \
  -device virtio-blk-device,drive=hd0 \
  -device virtio-net-device,netdev=usernet \
  -netdev user,id=usernet,hostfwd=tcp::"$ssh_port"-:22 \
  -device virtio-net-device,netdev=innet,mac="$macadd" \
  -netdev vde,id=innet,sock=/tmp/vde.ctl \
  -device qemu-xhci -usb -device usb-kbd -device usb-tablet"

echo ${YELLOW}:: Starting VM...${RESTORE}
echo ${YELLOW}:: Using following configuration${RESTORE}
echo ""
echo ${YELLOW}vCPU Cores: "$vcpu"${RESTORE}
echo ${YELLOW}Memory: "$memory"G${RESTORE}
echo ${YELLOW}Disk: "$drive"${RESTORE}
echo ${YELLOW}SSH Port: "$ssh_port"${RESTORE}
echo ""
echo ${YELLOW}:: NOTE: Make sure ONLY ONE .qcow2 file is${RESTORE}
echo ${YELLOW}in the current directory${RESTORE}
echo ""
echo ${YELLOW}:: Tip: Try setting DNS manually if QEMU user network doesn\'t work well. ${RESTORE}
echo ${YELLOW}:: HOWTO -\> https://serverfault.com/a/810639 ${RESTORE}
echo ""
echo ${YELLOW}:: Tip: If \'ping\' reports permission error, try reinstalling \'iputils\'. ${RESTORE}
echo ${YELLOW}:: HOWTO -\> \'sudo dnf reinstall iputils\' ${RESTORE}
echo ""

sleep 2

eval $cmd
```

4. 分别启动两台虚拟机，查看各自的 IP 地址：`ip a`

5. 在其中一台虚拟机上安装 `nmap` 并运行端口扫描：

```bash
sudo dnf install -y nmap
sudo nmap -sS -p- 10.0.2.15
```

其中 `10.0.2.15` 为另一台虚拟机的 IP 地址，在上一步中获得。

6. 等待扫描完成，查看结果。

#### 参考文档

- [适用于 QEMU 多节点的 VDE 网络配置指南](https://github.com/ArielHeleneto/Work-PLCT/blob/master/openMPI/VDE-network.md) by ArielHeleneto

-->

### 3. 长稳测试 / LTP long stress

Linux Test Project / LTP 中的 stress 组件可用于对内核进行压稳测试。

```bash
# 请先切换至 root 用户进行操作。如已为 root 用户登录请忽略。
# sudo -i
wget https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/raw/master/BasicTest/%E9%95%BF%E7%A8%B3%E6%B5%8B%E8%AF%95/LTPstress/run_ltpstress.sh
bash run_ltpstress.sh
```

> 目前脚本默认压测 24 小时，如需修改，请将脚本中的 `sh ltpstress.sh -n -m 512 -t 24` 的 24 修改为其他数值。

### 4.编译器测试

#### 4.1. dejagnu

1. 安装 dejagnu 和 GCC

```bash
sudo dnf install -y dejagnu gcc gcc-*
```

2. 获取 `gcc` 源码及其自带的测试套

```bash
git clone --depth=1 https://gitee.com/openeuler/gcc
cd gcc/gcc/testsuite
```

3. 分别运行 gcc, g++, gfortran 的测试套

```bash
runtest --tool gcc
runtest --tool g++
runtest --tool gfortran
```

4. 查看测试结果

测试结束后，会在当前目录下生成 `.log` 日志文件和 `.sum` 统计信息，可进行查看。

#### 4.2. Anghabench

一个包含 100 万个可编译程序的基准套件，从 GitHub 上最大的公共 C 存储库中挖掘出来

##### 测试部署环境准备

从 [此](https://github.com/brenocfg/AnghaBench/) 获得 AnghaBench 项目代码并使用 [该脚本](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/BasicTest/%E7%BC%96%E8%AF%91%E5%99%A8%E6%B5%8B%E8%AF%95/AnghaBench/compile.sh) 运行测试

#### 4.3. csmith

csmith 是适用于编译器的冒烟测试工具，能够生成大量合法的 C 文件作为测试用例，进而测试 C 编译器的标准性。

##### 安装

从 [GitHub 仓库](https://github.com/csmith-project/csmith) 获取源代码，该项目使用 CMake 作为构建工具，需要安装 cmake。

```
# dnf install cmake
```

使用 CMake 进行编译并安装

```
# cmake . && make -j16 && make install
```

此时可以使用 `csmith` 命令，如果成功输出一段 C 代码即安装成功。

##### 测试

***要求的样本量（百万量级）过于庞大，测试所需时间不现实。***

使用 `csrc.mk`, `list.mk`, `makefile`, `epoch.sh` 借助 make 的并行化构建功能
编写简单的测试驱动脚本。

在安装了 csmith 及 gcc, clang 的机器运行

```
$ ./epoch.sh THREAD_NUM
```

其中 THREAD\_NUM 为并行线程数量，设置为 CPU 数目的 1.25 倍较为合适。

该脚本会不停机地进行冒烟测试，使用 ^C 快捷键终止。csmith 生成的代码将会分别由
GCC，Clang 以五种不同的优化开关（`-O0`, `-O1`, `-O2`, `-O3`, `-Os`）进行编译，
产出可执行文件将会进行运行并对比输出结果的 SHA256 校验值。

##### 使用 csmith 自带的脚本进行自动化测试

`csmith` 在 `scripts` 目录下提供了一个 `compiler_test.tl` 脚本可用于自动化测试。

在 `compiler_test.in` 中定义了使用的编译器和优化级别。

> Note: 该脚本为单线程执行。

执行如下内容（注意将 `CSMITH_PATH` 更改为真实的 `csmith` 目录，`100` 为执行测试用例个数）：

```bash
cd scripts
CSMITH_HOME=<CSMITH_PATH> ./compiler_test.pl 100 compiler_test.in 2>&1 | tee ~/csmith.log
```

结束后可在 `~/csmith.log` 下查看日志。

#### 4.4. yarpgen

yarpgen 是由 Intel 编写的编译器冒烟测试套件。

##### 编译安装

从[GitHub 仓库](https://github.com/intel/yarpgen)获取源代码。

该项目使用 CMake 构建系统，需要安装 CMake

```
dnf install cmake
```

编译 yarpgen

```
cmake . && make -j16
```

##### 运行测试

参考脚本[auto\_test.sh](./auto_test.sh)。该脚本调用 `clang` 和 `gcc`
分别使用 `-O0`, `-O1`, `-O2`, `-O3` 与 `-Os` 对 yarpgen 生成的代码进行
编译运行并对比结果。

调用方式

```
./auto_test.sh TEST_NUM
```

其中 `TEST_NUM` 为要进行的测试数量。

注意，`clang` 默认并未安装，可能需要 `dnf install clang` 安装才能正常进行
测试。

<!--
#### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                                                                                                                   |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24            |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，通过长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24                                                        |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                        | **指标值**           | **说明**                       |
|----------|---------------------------------------------------------------------------------|-------------------|------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线数据差异小于5%以内可接受 |

#### 虚拟化兼容性

虚拟化兼容性(即openEuler本版本的虚拟机能否在其余OS host)
* 常用桌面虚拟化软件对openEuler的支持
* 常用linux发行版对openEuler虚机镜像的支持
* openEuler对常见linux发行版虚机镜像的支持

### 软件包管理专项测试

软件包(openEuler中特指RPM包)测试，基于历史20.03至今发现的质量问题总结。
* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                                           | **中英文测试策略** |
|----------------|--------------------------------------------------------------------|-------------|
| DDE安装指南        | 安装步骤的准确性及DDE桌面系统是否能成功安装启动                        | 英文描述的准确性   |
| UKUI安装指南       | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动                       | 英文描述的准确性   |
| KIRAN安装指南      | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动                      | 英文描述的准确性   |
| XFCE安装指南       | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动                       | 英文描述的准确性   |
| GNOME安装指南      | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动                      | 英文描述的准确性   |
| 树莓派安装指导     | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南           | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 管理员指南         | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 安全加固指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 虚拟化用户指南     | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| StratoVirt用户指南 | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 容器用户指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 应用开发指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 工具集用户指南     | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |

# 测试执行策略

openEuler 23.03 版本按照社区 release-management 团队既定的版本计划，共有 5 轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取 1+3+1 的测试方式，即 1 轮基本功能保障发布 beta 版本可以提供给外部开发者，3 轮全量保障本次版本发布所有特性(新增&继承)以及系统其他 DFX 能力，1 轮回归。
-->

### 测试执行 —— 测试阶段 1

- 继承特性/新特性的基本功能 
    -> 特性测试
- 交付重要组件（内核、虚拟化、容器、编译器等）的功能完整性
    -> 基础测试 & 特性测试
- 系统集成方面保证多组件多模块集成的正确性和整体系统的完整性
- 通过软件包管理测试，对发布软件的可安装进行整体保证
  -> CI 门禁
- 专项测试：
    - 性能：保证版本的性能满足发布基线标准，不能低于版本性能指标
      -> 基础性能测试
    - 南向兼容性验证：硬件开发板
      -> 特性支持

#### 产出内容

- 版本特性测试报告
  - 内核、虚拟化、容器、编译器等
- 版本专项测试报告
  - 性能、编译器、内核、长稳

### 测试执行 —— 测试阶段 2

- 继承特性/新特性的全量验证
- 通过自动化覆盖重要组件的功能 -> mugen
- 系统集成的正确性和完整性
- 软件包管理测试
- 专项测试：
    - 可靠性：保证版本的长时间稳定运行，建议运行时长 7*24 （LTP Stress）
    - 软件包 fuzz 测试

### 测试执行 —— 测试阶段 3

- 继承特性/新特性的自动化全量验证
- 系统集成验证
- 软件包管理测试
- 专项：性能、可靠性、文档测试
- 问题单回归

### 测试执行 —— 测试阶段 4

- 交付特性/组件的全量测试
- 问题单回归
- 软件包管理测试
- 系统集成测试
- 专项测试：
    - 可靠性
    - 性能
    - 文档

### 测试执行 —— 测试阶段 5

- 交付特性/组件的自动化全量测试
- 系统集成自动化测试项执行
- 问题单全量回归
- 专项测试：
    - 文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无