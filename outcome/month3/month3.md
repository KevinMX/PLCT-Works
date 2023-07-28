# month 3

记录本月产出。

1. 准备 `oErv 23.03 测试策略与结果同步` 演示文稿。[QA](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/reports/month3/month3-QA.md)

2. 对 oErv 23.09 kernel 6.4 进行初步测试，并进行结果分析。

- [LTP](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month3/23.09-kernel-6.4-pretest/LTP) 结果见下表。

| 测试套            | 测试套             | 问题分析                                                                            |
|-------------------|--------------------|-------------------------------------------------------------------------------------|
| clock_gettime03   | clock_gettime03    | 系统默认开启了时钟同步服务，需要停止 `systemd-timesyncd.service`                       |
| leapsec01         | leapsec01          | 同 `clock_gettime03`                                                                |
| clock_settime03   | clock_settime03    | 同 `clock_gettime03`                                                                |
| fallocate05       | fallocate05        | 超时，复测通过                                                                       |
| fallocate06       | fallocate06        | 超时，复测通过                                                                       |
| perf_event_open01 | perf_event_open01  | QEMU 环境下不支持                                                                   |
| thp01             | thp01 -I 120       | 超时，复测通过                                                                       |
| vma05             | vma05.sh           | 见 https://github.com/linux-test-project/ltp/issues/477 ，测试用例本身问题           |
| irqbalance01      | irqbalance01       | 默认未安装&未开启 `irqbalance`，需要手动安装并启动 `irqbalance` 服务                     |
| clock_gettime03   | clock_gettime03    | 时钟问题同上                                                                        |
| memcg_stat_rss    | memcg_stat_rss.sh  | 超时，复测通过                                                                       |
| hugemmap24        | hugemmap24         | `TINFO: can't use slice_boundary: 0x100000000000: ENOMEM (12)`                        |
| df01_sh           | df01.sh            | 测试脚本未能释放分区，卸载参数不合适，测试用例本身问题；mkfs 和 mkswap 均为此问题，下同 |
| mkfs01_sh         | mkfs01.sh          | 同 `df01_sh`                                                                        |
| mkfs01_ext2_sh    | mkfs01.sh -f ext2  | 同 `df01_sh`                                                                        |
| mkfs01_ext3_sh    | mkfs01.sh -f ext3  | 同 `df01_sh`                                                                        |
| mkfs01_ext4_sh    | mkfs01.sh -f ext4  | 同 `df01_sh`                                                                        |
| mkfs01_xfs_sh     | mkfs01.sh -f xfs   | 同 `df01_sh`                                                                        |
| mkfs01_btrfs_sh   | mkfs01.sh -f btrfs | 同 `df01_sh`                                                                        |
| mkfs01_minix_sh   | mkfs01.sh -f minix | 同 `df01_sh`                                                                        |
| mkfs01_msdos_sh   | mkfs01.sh -f msdos | 同 `df01_sh`                                                                        |
| mkfs01_vfat_sh    | mkfs01.sh -f vfat  | 同 `df01_sh`                                                                        |
| mkfs01_ntfs_sh    | mkfs01.sh -f ntfs  | 同 `df01_sh`                                                                        |
| mkswap01_sh       | mkswap01.sh        | 同 `df01_sh`                                                                        |
| cve-2011-0999     | thp01 -I 120       | 超时，复测通过                                                                       |
| cve-2020-25705    | icmp_rate_limit01  | ICMP rate limit not randomized, system is vulnerable                                |
| kmsg01            | kmsg01             | 超时，复测通过                                                                       |
| zram01            | zram01.sh          | 超时，复测通过（单项耗时两天）                                                         |

- Trinity 仍会出现内核 tainted 状态，测试无法完成。详细结果见 [trinity](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month3/23.09-kernel-6.4-pretest/trinity)。

3. 整理测试策略以方便日后测试工作的开展，以及日后提交给 sig-QA 进行评审。见 [oErv-2303-test](https://gitee.com/yunxiangluo/oerv-2303-test)。

- 编译器测试
    - [AnghaBench](/BasicTest/compilers/AnghaBench/)：通过
    - [csmith](/BasicTest/compilers/csmith/)：由于RISC-V环境影响，执行速度慢，通过 200 个测试用例
    - [dejagnu](/BasicTest/compilers/dejagnu/)：通过
    - [jotai](/BasicTest/compilers/jotai/)：通过
    - [yarpgen](/BasicTest/compilers/yarpgen/)：由于RISC-V环境影响，执行速度慢，通过 200 个测试用例

- 功能测试
    - [mugen BaseOS](/BasicTest/function/mugen/)：
    - [LTP](/BasicTest/function/LTP/)：通过

- 内核测试
    - [trinity](/BasicTest/kernel/trinity/)：未通过

- 性能测试
    - [fio](/BasicTest/performance/fio/)：通过
    - [libMicro](/BasicTest/performance/libMicro/)：通过
    - [lmbench](/BasicTest/performance/lmbench/)：通过
    - [netperf](/BasicTest/performance/netperf/)：通过
    - [stream](/BasicTest/performance/stream)：通过
    - [unixbench](/BasicTest/performance/unixbench/)：通过

- 长稳测试
    - [LTP Stress](/BasicTest/long_stress/LTPstress/)：未通过

- QEMU 兼容性测试
    - [QEMU 8.0 +](/docs/InstallationBook/QEMU/)：通过

- 文档测试
    - 对文档准确性进行验证：现有文档验证通过

4. 尝试执行 kubernetes E2E 测试：[Gitee](https://gitee.com/KevinMX/openeuler-riscv-2303-test/commit/069176111d42a5f29a0a0b08d3b94c1de4beba20)

> `kubetest` 测试组件已被 kubernetes 上游 deprecated。

5. 调研&尝试在现有的 6.4 内核上使用 `kpatch` 对内核进行热补丁，产出测试用例&文档见：[kpatch](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month3/kpatch)。

> mugen BaseOS 已包含对 `kpatch.service` 启动的测试，已通过。

6. 调研 `greatsql`。

> mugen 已包含对 `mysqlrouter.service` 启动的测试，已通过。