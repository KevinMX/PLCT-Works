# month 1

记录本月产出。

## 测试用例 / testcases

1. 容器相关（见 [此处](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Containers)）

- Docker
- iSulad （包括 Native Network / CNI 网络特性）
- 系统容器
- 安全容器
- 容器镜像构建

2. 其他软件包
- libcareplus [testcase](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/libcareplus)
- kconfigDetector [testcase](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/kconfigDetector)

3. 硬件测试

- StarFive VisionFive 2 [testcase](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/Hardware_Test/Visionfive2)

## 文档内容

- StarFive VisionFive 2 安装文档更新，补充安装系统至 NVMe 硬盘方法 [docs](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/Installation_Book/Visionfive2)
- UKUI 使用文档 [docs](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/User_Book/UKUI%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C)
- Kiran 使用文档 [docs](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/User_Book/Kiran%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C)
- JDK 安装文档 [docs](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/JDK)

## 缺陷报告 / issues

|ID|缺陷内容|状态|
|-|-|-|
|[I6R1UT](https://gitee.com/openeuler/RISC-V/issues/I6R1UT)|iSulad 无法启动|Fixed|
|[I6R1UT](https://gitee.com/openeuler/RISC-V/issues/I6RDWA)|isula-build 服务无法启动|Fixed|
|[I6RSAC](https://gitee.com/openeuler/RISC-V/issues/I6RSAC)|lxcfs 服务无法启动|Fixed|
|[I6R9OQ](https://gitee.com/openeuler/RISC-V/issues/I6R9OQ)|kata-containers 软件包缺失|Confirmed - WIP|
|[I6WHYU](https://gitee.com/openeuler/RISC-V/issues/I6WHYU)|23.03 Kiran 桌面安装并重启后默认不会开启网络连接|Confirmed - WIP|
|[I6WRSY](https://gitee.com/openeuler/RISC-V/issues/I6WRSY)|23.03 6.1 内核下无法启动 Firefox|TBD|

## 合并请求 / Pull Requests

openEuler RISC-V 23.03 测试：

[!36 认领&更新：容器/containers](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/pulls/36)

[!51 更新 VisionFive 2 测试用例及安装说明](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/pulls/51)

[!61 文档更新](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/pulls/61)

[!62 更新 UKUI 文档，认领任务](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/pulls/62)

[!64 更新部分使用文档和测试用例](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/pulls/64)

## 其他内容

- 重新整理 openEuler RISC-V 23.03 的测试内容，对于不清楚的部分需求进行调研，对先前未完成的部分软件包在 23.03 进行回归测试，整理所有软件包对应 SIG 组，并对已测试软件包可用性进行统计。

  - 整理结果见 [此处](../../misc/month1/what-is-this.md)

- 针对 QA 组测试需求进行基础测试，目前已完成 unixbench、libmicro、fio、stream、lmbench；LTP Stress / 压稳测试需要时间较长，目前仍在运行中。

  - 结果见 [Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/BasicTest/res.md)。
