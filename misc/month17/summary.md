## 操作系统支持矩阵

仓库地址：https://github.com/ruyisdk/support-matrix

### 预期目标

测试和验证每一款 RISC-V 开发板可以跑哪些操作系统和软件，以及每一款软件可以支持哪些 RISC-V 指令集扩展集合、从哪个版本开始支持、现状如何。

方便用户迅速查找自己手上的开发板能用什么操作系统、怎么使用，快速上手。目标是覆盖市面上所有 RISC-V 开发板。

### 目前进度

已经基本覆盖了市面上所有常见开发板 + 操作系统的组合，并对已有的开发板做了验证。

测试报告包括硬件准备、使用方法/刷写步骤、点亮后系统日志输出（证明系统确实可用）等内容。

已经添加了 i18n / 英文翻译内容。

### 目前问题

- 部分开发板缺少硬件验证，只能做文档层面的调研
- RISC-V 各操作系统迭代较为迅速，需要持续观测更新情况；已经有部分系统的测试报告落后于主线版本，需要人工观测

### 后续计划

在操作系统支持矩阵内增加应用软件支持情况；由 lintestor 自动化测试工具 + 部分人工手动完成

### 自动化测试工具 lintestor

仓库地址：https://github.com/255doesnotexist/lintestor

### 预期目标

复刻 https://github.com/isrc-cas/tarsier-meta/blob/main/report/info.md 中原软件包可用性矩阵结果。给出 RISC-V 不同发行版下不同包可用的结果。计划加入串口连接方式和 GUI 相关测试。

### 目前进度

测试结果矩阵：https://github.com/255doesnotexist/lintestor/blob/main/summary.md

基本完成 Debian、Bianbu 部分。包的元数据信息记录获取方式仍待拓展。

支持测试配置为本地测试、连接远端开发板测试、借由 QEMU 进行测试三种类型。

测试内容灵活，可以自由编写测试脚本实现，亦可附带其他配置和二进制数据。框架仅负责统计合并结果。

## 自动化测试工具 boardtest

仓库地址：https://github.com/255doesnotexist/boardtest

### 预期目标

通过 SDWireC + 串口连接方式自动为 SD 卡内灌入不同操作系统。借由串口执行不同配置好命令的测试，以各类方式（返回值、字符串包含、Special Judge 等）判定测试结果。

### 目前进度

以上功能全部实现。

## 自动化测试工具 autotester

仓库地址：https://github.com/wychlw/autotester

### 预期目标

实现包括 CLI、GUI 在内的，板上自动化刷写、测试、生成 log 的操作。可通过串口、SSH、VNC、采集卡等方式进行多机交互，并给出相应测试结果。

### 目前进度

基本完成 CLI 部分编写，接入 SDWireC 允许自动刷写 SD 卡，可以通过 Python 脚本产出各类 log 和报告等。后续考虑继续在 CLI 部分加入通过 metadata、实时编写脚本并得到结果等以更加方便测试脚本的编写

相比于之前的自动测试工具具有高度扩展性，支持通过类似管道方式获取和过滤输入输出结果

## Demo 调研

### 预期目标

整理各个常用平台上的（可用到硬件特性）的 Demo，生成教学/实操文档，以便于用户搭建环境和使用。

### 目前进度

### StarFive VisionFive 2

大部分 demo 环境搭建文档和教学使用方式搜集完毕。

### Sipeed M1s Dock 

开发环境搭建和部分 demo 整理完毕

### BananaPi BPI-F3 

已搜集了一些 RVV 1.0 相关 Demo：https://github.com/255doesnotexist/bpi-f3_demos

### Milk-V Duo 

已搜集并整理了大量 Arduino、pinpong、wiringX 库等 Demo：https://github.com/ArielHeleneto/Work-PLCT/tree/master/duo/Board

有相关视频产出，有部分教程已经有短视频小队制作整理发在 bilibili

调研过程中遇到的 bug 已经向上游提交

