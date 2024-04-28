# week 3 / 本周工作

2024.04.22 ~

## 操作系统支持矩阵

- [Lichee RV Nano](https://github.com/ruyisdk/support-matrix/commit/73c1f8990a7b5e2f27c6c86ab501cb1a4015610e)

- [Sipeed M0P DOck](https://github.com/ruyisdk/support-matrix/commit/73c1f8990a7b5e2f27c6c86ab501cb1a4015610e)

审核实习生提交的 PR：

https://github.com/KevinMX/support-matrix/pull/6

https://github.com/KevinMX/support-matrix/pull/7

https://github.com/KevinMX/support-matrix/pull/8

https://github.com/KevinMX/support-matrix/pull/9

## RuyiSDK 测试

### ruyi 包管理器

0.9.0

| 内容                                     | PR                                                            |
|----------------------------------------|---------------------------------------------------------------|
| Lichee RV Nano 镜像刷写测试              | PR [!33](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/33) |
| oERV 2309 Pioneer 自动化测试             | PR [!33](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/33) |
| oERV 2309 LPi4A 自动化测试               | PR [!33](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/33) |
| openKylin v1.0.1 VisionFive 2 自动化测试 | PR [!36](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/36) |

### 自动测试脚本

- 添加 openKylin 支持 - [commit](https://github.com/KevinMX/PLCT-Tarsier-Works/commit/c19c53c48cfc27d92856571d8f9a3748afa3fce2)
- 修改日志处理方式（修复 openKylin bash 上遇到的执行错误） - [commit](https://github.com/KevinMX/PLCT-Tarsier-Works/commit/fd236e25e586d5cc7d14f34688f9d9b42e967fe1)

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