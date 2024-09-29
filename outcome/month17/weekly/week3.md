# week 2 / 本周工作

2024.09.23 ~ 2024.09.29

## 操作系统支持矩阵

重写支持矩阵主文档：将 Linux/*BSD/RTOS/Others 分割成独立的表格，优化排版

PR Review:
- 文档校对 https://github.com/KevinMX/support-matrix/pull/37 https://github.com/KevinMX/support-matrix/pull/39
- Ubuntu 24.10 https://github.com/KevinMX/support-matrix/pull/38
- Arch Linux

### 其他内容

尝试修复 SG200x 系列 Debian 镜像构建（跟踪问题中，暂未提交）

目前已经发现的问题：

- fsbl/u-boot/kernel 仓库位置&内容变更
- patch 需要重新 rebase / 重写
- 构建过程有问题，容器镜像需要修复？
- 打出来的镜像可能无法启动，还需进一步调查原因
