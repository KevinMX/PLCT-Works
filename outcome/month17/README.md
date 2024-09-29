# month 17

记录本月产出。

## 操作系统支持矩阵

LPi4A / oERV: 基于官方 24.03 LTS 发版重测 [commit](https://github.com/ruyisdk/support-matrix/commit/1eb84b58709a6d2e6181651c46f8102bc43f7db6)

双周报支持矩阵部分内容同步：https://github.com/ruyisdk/wechat-articles/pull/85

PIC64GX Curiosity Kit 文档支持：https://github.com/ruyisdk/support-matrix/commit/35763decac4def0e31b768239b0eceb568b4acfc

Ubuntu 23.10 -> 24.04: [typo fix](https://github.com/KevinMX/support-matrix/commit/ba221296e602d70a18b8815ace501b8622860eea)

PIC64GX: [Ubuntu 24.04.1](https://github.com/KevinMX/support-matrix/commit/ce29167ca0cdc0b423852561c666748ede001a32)

重写支持矩阵主文档：将 Linux/*BSD/RTOS/Others 分割成独立的表格，优化排版：https://github.com/KevinMX/support-matrix/commit/7c38093075759eca26781e9ec3abec9d71956c8d

PR Review
- [BPI-F3 Armbian Noble](https://github.com/KevinMX/support-matrix/pull/35)
- [Bianbu 2.0 RC1](https://github.com/ruyisdk/support-matrix/pull/38)
- 文档校对：https://github.com/KevinMX/support-matrix/pull/37 https://github.com/KevinMX/support-matrix/pull/39
- [Ubuntu 24.10](https://github.com/KevinMX/support-matrix/pull/38)
- [Arch Linux](https://github.com/KevinMX/support-matrix/pull/40)

## 其它工作

尝试修复 SG200x / Duo S 的 Debian 镜像构建

（目前还在跟踪已有问题，暂时不方便提交）

目前已经发现的问题：

- fsbl/u-boot/kernel 仓库位置&内容变更
- patch 需要重新 rebase / 重写
- 构建过程有问题，容器镜像需要修复？
- 打出来的镜像可能无法启动，还需进一步调查原因

新人面试 & 考核。

