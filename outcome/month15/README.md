# month 15

记录本月产出。

## 操作系统支持矩阵

审核实习生提交的 PR：

https://github.com/KevinMX/support-matrix/pull/29 (oERV 24.03 LTS LPi4A)

https://github.com/KevinMX/support-matrix/pull/30 (D1 Link fix)

https://github.com/KevinMX/support-matrix/pull/32 (Fix typo)

https://github.com/KevinMX/support-matrix/pull/33 (vf, vf2, lpi4a, mars, unmatched: Deepin preveiw; vf2/openKylin: Update version)

https://github.com/KevinMX/support-matrix/pull/34 (Nuttx/DuoS)

提交至 ruyisdk 仓库：

https://github.com/ruyisdk/support-matrix/pull/29

- VisionFive 2
  - Ubuntu 23.10 -> 24.04 LTS
  - Fix file name typo
- Lichee Pi 4A
  - openEuler RISC-V 23.09 preview -> 24.03 LTS
- Milk-V Pioneer
  - openEuler RISC-V 23.09 preview -> 24.03 LTS
- HiFive Unmatched
  - Ubuntu 23.10 -> 24.04 LTS

https://github.com/ruyisdk/support-matrix/pull/32

vf, vf2, lpi4a, unmatched: add Deepin RISC-V 

新增：[Milk-V Jupiter - Bianbu](https://github.com/KevinMX/support-matrix/commit/9c54818831741b671da047bad6b3b81468341b1c)

更新：[Milk-V Duo S - Debian v1.4.0](https://github.com/KevinMX/support-matrix/commit/0c411e2a77d5658cde61af86742f3eeace52e13c)

Fix: [VisionFive 2 - openSUSE](https://github.com/KevinMX/support-matrix/commit/2712a108c928578f63bbd76bca897d2f90f8d3d0)

[visionfive2/ubuntu: fix link](https://github.com/KevinMX/support-matrix/commit/3f097258a7f8bea20bc26a5d41462b41a062fe43)

HiFive Unmatched: [更新测试报告至 Ubuntu 24.04 LTS](https://github.com/KevinMX/support-matrix/commit/6977b8e38f43dcbfbf4ac8c4270b45c69da2a4af)

Milk-V Pioneer: [新增 Deepin 23 preview](https://github.com/KevinMX/support-matrix/commit/6a7f56534ae10685846793fcb6ce19b6a5f37cff)

### 其他内容

- 新人面试，[Pre-Task 产出](https://github.com/255doesnotexist/boardtest/tree/main) Review。
- k3s: https://github.com/KevinMX/PLCT-Works/tree/main/misc/month15/k3s
    - 内核重编（增加内核选项）
    - 镜像刷写
    - 新内核安装
    - k3s 安装
    - 跟踪 Docker 问题（群内解答）：需要在 k3s 的内核配置基础上增加 `CONFIG_CGROUP_BPF=y`。
- openKylin 2.0 RC RISC-V 版本测试：[Pioneer 测试报告](https://gitee.com/yunxiangluo/openKylin-RISC-V-2.0-RC-Testing/pulls/4)/[主测试报告](https://gitee.com/yunxiangluo/openKylin-RISC-V-2.0-RC-Testing/pulls/5)
- 更新 RuyiSDK 双周报：https://github.com/ruyisdk/wechat-articles/commit/f3ab0a13104eec091f7bea9b9d3eb310b25da77a