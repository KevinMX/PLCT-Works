## week 0

### 本周工作

1. 入组考核&面试，熟悉 openEuler RISC-V。

基本完成了容器相关的测试用例，包括：
- Docker
- iSula(d)
- 系统容器
- 安全容器
- ...

相关缺陷报告：

|ID|缺陷内容|状态|
|-|-|-|
|[I6R1UT](https://gitee.com/openeuler/RISC-V/issues/I6R1UT)|iSulad 无法启动|Fixed|
|[I6R1UT](https://gitee.com/openeuler/RISC-V/issues/I6RDWA)|isula-build 服务无法启动|Fixed|
|[I6RSAC](https://gitee.com/openeuler/RISC-V/issues/I6RSAC)|lxcfs 服务无法启动|Fixed|
|[I6R9OQ](https://gitee.com/openeuler/RISC-V/issues/I6R9OQ)|kata-containers 软件包缺失|Confirmed - WIP|

2. 更新 StarFive VisionFive 2 的安装说明，更新硬件测试内容。

### 其他内容

- 使用 OBS/osc 本地构建 coreutils。
- 测试需要暂且白嫖了一块开发板，~~迟早要还的（确信~~：[赛昉科技 昉·星光 2 / StarFive VisionFive 2 初上手](https://mary.kevinmx.top/default/visionfive2.html)

- [交叉编译 U-Boot & OpenSBI for RISC-V](https://mary.kevinmx.top/default/opensbirv64.html)
