# month 1

记录本月产出。

## 测试用例 / testcases

按照 sig-QA [openEuler 社区测试能力执行指南](https://gitee.com/openeuler/QA/blob/master/openEuler%E7%A4%BE%E5%8C%BA%E6%B5%8B%E8%AF%95%E8%83%BD%E5%8A%9B%E6%89%A7%E8%A1%8C%E6%8C%87%E5%8D%97/openEuler%E7%A4%BE%E5%8C%BA%E6%B5%8B%E8%AF%95%E8%83%BD%E5%8A%9B%E6%89%A7%E8%A1%8C%E6%8C%87%E5%8D%97.md)，对 openEuler 23.03 进行基础测试。本月完成：

1. 基础性能测试 on D1 Nezha/LicheeRV, HiFive Unmatched, VisionFive 1/2

- [unixbench](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%9F%BA%E7%A1%80%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95/unixbench)
- [libmicro](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%9F%BA%E7%A1%80%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95/libMicro)
- [fio](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%9F%BA%E7%A1%80%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95/fio)
- [stream](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%9F%BA%E7%A1%80%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95/stream)
- [lmbench](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%9F%BA%E7%A1%80%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95/lmbench)

2. 安全测试 on QEMU

- [nmap](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%AE%89%E5%85%A8%E6%B5%8B%E8%AF%95/nmap)

3. 长稳测试 on QEMU

- [LTP Stress](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E9%95%BF%E7%A8%B3%E6%B5%8B%E8%AF%95/LTPstress)

4. 内核测试 on QEMU（新内核）

- [trinity/rerun](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%86%85%E6%A0%B8%E6%B5%8B%E8%AF%95/trinity/rerun)

5. 功能测试 on QEMU（新内核）

- [LTP/rerun](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%8A%9F%E8%83%BD%E6%B5%8B%E8%AF%95/LTP/rerun)

6. 编译器测试 on QEMU

- [dejagnu](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E7%BC%96%E8%AF%91%E5%99%A8%E6%B5%8B%E8%AF%95/dejagnu)

- [csmith](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E7%BC%96%E8%AF%91%E5%99%A8%E6%B5%8B%E8%AF%95/csmith), 因样本量过大耗时过久，仅测试运行 100 个

## 缺陷报告 / issues

|ID|缺陷内容|状态|
|-|-|-|
|[I70JPM](https://gitee.com/openeuler/RISC-V/issues/I70JPM)|23.03 使用 D1 SoC 的开发板上 fio 无法正常运行|TBD|

## 合并请求 / Pull Requests

src-openEuler/lmbench:

[!19 修复 RISC-V 支持](https://gitee.com/src-openeuler/lmbench/pulls/19) （等待合并）

## 其他内容

1. 在 D1 开发板上通过 QEMU 启动 Core-V-MCU/RT-Thread BSP，编写相关文档。见 [/misc/month1/week2/rt-thread](/misc/month1/week2/rt-thread/README.md)。

2. 针对部分项目，在 openEuler 23.03 x86_64 平台执行测试并与 oErv 进行对比，筛选 oErv 独有/架构强相关问题。目前已对比项包括：

- [lmbench](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%9F%BA%E7%A1%80%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95/lmbench)
- [dejagnu](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E7%BC%96%E8%AF%91%E5%99%A8%E6%B5%8B%E8%AF%95/dejagnu)