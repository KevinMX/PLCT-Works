## week 0

2024.01.08 ~ 2024.01.12

### 本周工作

- SG2042 测试工作
    - 更换了 SG2042 PCI-E Switch 桥片风扇，继续进行测试与结果分析：[mmtests](/misc/month9/mmtests/)
- 修包工作：iozone spec 添加 riscv64 支持 [!PR](https://gitee.com/src-openeuler/iozone/pulls/7) （已合入）
- 技术报告：[开源自动化测试工具 openQA 在 openEuler RISC-V 测试中的使用](/reports/month9/开源自动化测试工具openQA在openEuler%20RISC-V测试中的使用.pdf)
- RuyiSDK IDE 调研工作：[基于 VSCode，尝试走通 RISC-V 架构 C 的编译、调试流程](https://github.com/ruyisdk/pmd/issues/5) -> 文档见 [此处](/misc/month9/vscode.md)

#### SG2042 mmtests 结果分析

所有测试项目都有的问题：

- mmtest 未能识别发行版名称，故所有测试均报 `Failed to identify distribution`，预期结果/非问题。
- `cat: '/sys/devices/system/cpu/cpu0/cache/index*/shared_cpu_list': No such file or directory`

| 测试项                                          | 结果分析                                                                                                       |
|-------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| config-buildtest-hpc-blas.log                   | mmtests 选用的 OpenBLAS 版本未适配 RISC-V                                                                                  |
| config-buildtest-hpc-cmake.log                  | cmake --libdir 选项不可用；未适配 RISC-V                                                                              |
| config-buildtest-hpc-fftw.log                   | PASS                                                                                                           |
| config-buildtest-hpc-gmp.log                    | PASS                                                                                                           |
| config-buildtest-hpc-mpfr.log                   | /opt/mmtests/work/sources/gmpbuild-6.1.2-installed/lib64 路径不存在，只存在 lib，疑似未识别 riscv64，测试用例问题 |
| config-buildtest-hpc-revocap.log                | PASS                                                                                                           |
| config-db-sqlite-insert-small.log               | PASS                                                                                                           |
| config-functional-ltp-containers.log            | PASS                                                                                                           |
| config-functional-ltp-cve.log                   | PASS                                                                                                           |
| config-functional-ltp-lite.log                  | PASS                                                                                                           |
| config-functional-ltp-mm.log                    | PASS                                                                                                           |
| config-functional-ltp-netstress.log             | PASS                                                                                                           |
| config-functional-ltp-realtime.log              | PASS                                                                                                           |
| config-hpc-graph500-omp-infant.log              | 默认编译参数是 -march=native，需要修改为 rv64                                                                   |
| config-hpc-scimarkc-small.log                   | PASS                                                                                                           |
| config-io-blogbench.log                         | PASS                                                                                                           |
| config-io-dbench4-async.log                     | PASS                                                                                                           |
| config-io-fio-randread-direct-multi.log         | PASS                                                                                                           |
| config-io-fio-randread-sync-heavywrite.log      | PASS                                                                                                           |
| config-io-fio-randread-sync-randwrite.log       | PASS                                                                                                           |
| config-io-fio-scaling.log                       | PASS                                                                                                           |
| config-io-fio-ssd.log                           | PASS                                                                                                           |
| config-io-paralleldd-read-small.log             | PASS                                                                                                           |
| config-io-sparsetruncate-small.log              | PASS                                                                                                           |
| config-io-trunc.log                             | PASS                                                                                                           |
| config-io-xfsio.log                             | PASS                                                                                                           |
| config-memdb-redis-benchmark.log                | configs/config-memdb-redis-benchmark 未配置                                                                    |
| config-multi-tbench__netperf-tcp-rr.log         | PASS                                                                                                           |
| config-network-netperf-cross-socket.log         | configs/config-network-netperf-cross-socket未配置                                                              |
| config-network-netperf-rr-unbound.log           | PASS                                                                                                           |
| config-network-netperf-unix-unbound.log         | PASS                                                                                                           |
| config-network-obsolete-netperf-rr-cstate.log   | configs/config-network-obsolete-netperf-rr-cstate 未配置                                                       |
| config-network-obsolete-netperf-unbound.log     | configs/config-network-obsolete-netperf-unbound 未配置                                                         |
| config-pagereclaim-stutter.log                  | configs/config-pagereclaim-stutter 未配置                                                                      |
| config-scheduler-adrestia-single-unbound.log    | PASS                                                                                                           |
| config-scheduler-saladfork.log                  | PASS                                                                                                           |
| config-scheduler-sysbench-mutex.log             | 未适配 riscv64                                                                                                 |
| config-scheduler-sysbench-thread.log            | 未适配 riscv64                                                                                                 |
| config-workload-aim9-pagealloc.log              | PASS                                                                                                           |
| config-workload-ebizzy.log                      | PASS                                                                                                           |
| config-workload-freqmine.log                    | PASS                                                                                                           |
| config-workload-poundsyscall.log                | PASS                                                                                                           |
| config-workload-spinplace-long.log              | PASS                                                                                                           |
| config-workload-spinplace-short.log             | PASS                                                                                                           |
| config-workload-stream-omp-llcs.log             | PASS                                                                                                           |
| config-workload-stream-omp-nodes.log            | PASS                                                                                                           |
| config-workload-stream-single.log               | PASS                                                                                                           |
| config-workload-stressng-class-io-parallel.log  | PASS                                                                                                           |
| config-workload-stressng-context.log            | PASS                                                                                                           |
| config-workload-stressng-get.log                | PASS                                                                                                           |
| config-workload-stressng-mmap.log               | PASS                                                                                                           |
| config-workload-thotdata.log                    | PASS                                                                                                           |
| config-workload-thpscale-madvhugepage.log       | configs/config-workload-thpscale-madvhugepage 未配置                                                           |
| config-workload-thpscale.log                    | configs/config-workload-thpscale 未配置                                                                        |
| config-workload-unixbench-io-fsbuffer.log       | 版本号未定义，下载失败                                                                                          |
| config-workload-unixbench-io-fsdisk.log         | 版本号未定义，下载失败                                                                                          |
| config-workload-unixbench-io-fstime.log         | 版本号未定义，下载失败                                                                                          |
| config-workload-unixbench.log                   | 版本号未定义，下载失败                                                                                          |
| config-workload-unixbenchd-syscall-context1.log | 版本号未定义，下载失败                                                                                          |
| config-workload-unixbenchd-syscall-getpid.log   | 版本号未定义，下载失败                                                                                          |
| config-workload-usemem.log                      | PASS                                                                                                           |
| config-workload-will-it-scale-io-processes.log  | PASS                                                                                                           |
| config-workload-will-it-scale-io-threads.log    | PASS                                                                                                           |
| config-workload-will-it-scale-pf-processes.log  | PASS                                                                                                           |
| config-workload-will-it-scale-sys-processes.log | PASS                                                                                                           |