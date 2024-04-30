# month 12

记录本月产出。

## RuyiSDK

### ruyi 包管理器

| 内容                                           | PR                                                            |
|----------------------------------------------|---------------------------------------------------------------|
| 0.8.0 测试报告                                 | PR [!28](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/28) |
| 0.8.1 测试报告                                 | PR [!31](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/31) |
| Milk-V Meles 镜像刷写测试                      | PR [!29](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/29) |
| Lichee RV Nano 0.9.0 镜像刷写测试              | PR [!33](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/33) |
| oERV 2309 Pioneer 0.9.0 自动化测试             | PR [!33](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/33) |
| oERV 2309 LPi4A 0.9.0 自动化测试               | PR [!33](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/33) |
| openKylin v1.0.1 VisionFive 2 0.9.0 自动化测试 | PR [!36](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/36) |

#### 自动化测试脚本

| commit                                                                  | 内容                                                   |
|-------------------------------------------------------------------------|------------------------------------------------------|
| [9f77b8f](https://github.com/KevinMX/PLCT-Tarsier-Works/commit/9f77b8f) | 使用非特权用户执行测试                                 |
| [e776978](https://github.com/KevinMX/PLCT-Tarsier-Works/commit/e776978) | 修复 log 处理                                          |
| [c19c53c](https://github.com/KevinMX/PLCT-Tarsier-Works/commit/c19c53c) | 添加 openKylin 支持                                    |
| [fd236e2](https://github.com/KevinMX/PLCT-Tarsier-Works/commit/fd236e2) | 修改日志处理方式（修复 openKylin bash 上遇到的执行错误） |

#### 缺陷列表

| Issue                                              | 标题                                                     | 状态                   |
|----------------------------------------------------|----------------------------------------------------------|------------------------|
| [#128](https://github.com/ruyisdk/ruyi/issues/128) | device provision fails to unpack image for Meles & LPi4A | Closed, fixed in 0.8.1 |

### 操作系统支持矩阵

https://github.com/ruyisdk/support-matrix/

| Commit Hash                                                                                          | Info                                     |
|------------------------------------------------------------------------------------------------------|------------------------------------------|
| [e1f3881](https://github.com/ruyisdk/support-matrix/commit/e1f38812e2a16667abdfc1daa9927f5ee0934594) | 添加 lc4a, lcon4a, LicheeRV Nano, Maix-I |
| [649a8c2](https://github.com/KevinMX/support-matrix/commit/649a8c21d2d900a8ce1fef7cde15a344641dc189) | 添加嘉楠 K510                            |
| [d5e494c](https://github.com/KevinMX/support-matrix/commit/d5e494caf35ad6058b893868cec67a6066d01423) | Vega 交换机固件编译步骤更新              |
| [340fd0f](https://github.com/KevinMX/support-matrix/commit/340fd0fd7c7a49b8a035ef9b9ac1ffe2bc2aa802) | 添加 Sipeed M0sense                      |
| [73c1f89](https://github.com/ruyisdk/support-matrix/commit/73c1f8990a7b5e2f27c6c86ab501cb1a4015610e) | 添加 LicheeRV Nano                       |
| [73c1f89](https://github.com/ruyisdk/support-matrix/commit/73c1f8990a7b5e2f27c6c86ab501cb1a4015610e) | 更新 M0P Dock                            |

审核实习生提交的 PR：

https://github.com/KevinMX/support-matrix/pull/1

https://github.com/KevinMX/support-matrix/pull/2

https://github.com/KevinMX/support-matrix/pull/3

https://github.com/KevinMX/support-matrix/pull/4

https://github.com/KevinMX/support-matrix/pull/5

https://github.com/KevinMX/support-matrix/pull/6

https://github.com/KevinMX/support-matrix/pull/7

https://github.com/KevinMX/support-matrix/pull/8

https://github.com/KevinMX/support-matrix/pull/9

https://github.com/KevinMX/support-matrix/pull/10

[Lichee Cluster 4A & TANG Mega 138K Pro (AE350)](https://github.com/ruyisdk/support-matrix/pull/13)

[Lichee Cluster 4A](https://github.com/ruyisdk/support-matrix/pull/12)

[VisionFive 2](https://github.com/ruyisdk/support-matrix/pull/10)

[K230](https://github.com/ruyisdk/support-matrix/pull/10)

## 其他工作

### TiDB 测试

在 openEuler 23.09 x86_64、RevyOS 20240327 (Pioneer v1.3) 上分别进行了测试。

编写了[文档/测试报告](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month12/TiDB/TiDB.md)。

其中包含：

- riscv64 平台部署步骤
    - tikv 编译
    - pd-server 编译
    - tidb-server 编译
- sysbench 性能测试
    - LuaJIT 临时 workaround
- go-tpc (TPC-C) 性能测试
- x86_64、SG2042@10T、SG2042@64T、SG2042@64T/500 warehouses 性能对比