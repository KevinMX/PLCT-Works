# week 2 / 本周工作

2024.07.22 ~ 2024.07.26

## 操作系统支持矩阵

补上了上期意外丢失的 deepin RISC-V 测试报告 commit。

https://github.com/ruyisdk/support-matrix/pull/32

审核实习生提交的 PR：https://github.com/KevinMX/support-matrix/pull/34

### 其他内容

openKylin 2.0 RC RISC-V 版本测试。

Milk-V Pioneer 测试报告：https://gitee.com/yunxiangluo/openKylin-RISC-V-2.0-RC-Testing/pulls/4

主测试报告：https://gitee.com/yunxiangluo/openKylin-RISC-V-2.0-RC-Testing/pulls/5

继续跟踪 k3s / Docker on Duo S 的问题：

> 如果需要跑 Docker，需要在 k3s 的内核配置基础上增加 `CONFIG_CGROUP_BPF=y`。

更新 RuyiSDK 双周报：https://github.com/ruyisdk/wechat-articles/commit/f3ab0a13104eec091f7bea9b9d3eb310b25da77a