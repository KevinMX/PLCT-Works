---
marp: true
theme: default
footer: 'PLCT Lab 测试团队 · 丁丑小队 | [Kevin.MX](https://github.com/KevinMX), CC-BY 4.0'
paginate: true
size: 16:9
---
<style>
section {
  font-family: 'Noto Sans CJK SC', 'Noto Sans Mono', 'Noto Serif CJK SC'
}
</style>

# RuyiSDK 与 RISC-V 操作系统支持矩阵 

PLCT Lab 测试团队 · 丁丑小队

<!-- _paginate: "skip" -->

---

# 我是谁 | Who am I

- PLCT Lab 测试团队 · 丁丑小队
- RISC-V 开发板软件生态联合观测 / J129 Mentor
- Previously: 第三测试小队
- GitHub [@KevinMX](https://github.com/KevinMX)
  - ~~常用 ID 后半截的 MX 其实才是本体~~
  - ~~随机刷新在互联网各个角落，见到了叫我 MX 就好~~

<!-- footer: "" -->

---

# 内容概述

- 2024 Summary: 我们做了什么
- 缘起
- 当下
    - RuyiSDK
    - Introducing: RISC-V 操作系统支持矩阵
    - 自动化测试工具
        - 软件/自动化测试框架
        - 硬件工具
- 未来/许愿？

<!-- footer: "" -->

---

# 2024 Summary: What we did

- 支持矩阵项目已经覆盖/跟踪了绝大部分开发者能买得到的开发板×系统组合
    - 总计调研了约 50 款开发板，涉及到 20 余种操作系统
- 开发板 x 系统支持情况的表格现在是 CI 自动生成了
- 与 RuyiSDK packages-index 的自动更新机制已经初步就绪
- i18n (-en) 和 issue template 安排上了
- 软件/硬件自动化测试工具已经开始投入使用
- 应用软件生态观测逐步开始
    - 操作系统之外，亦对浏览器、数据库等常用软件进行测试
    - 部分已在 GitHub 公开测试报告
- 小队成员积极参与社区开源项目贡献
    - 对测试过程中遇到的各类问题向上游反馈和主动修复

---

# 缘起

![RISC-V Day Tokyo 2024.01](../../month16/PLCT_OpenDay_2024/image/2024-08-19-04-20-57.png)

---

# 当下

![Timeline](../../month16/PLCT_OpenDay_2024/image/timeline.png)

---

## RuyiSDK

[RuyiSDK](https://ruyisdk.org/) 是一个由 [PLCT Lab](https://plctlab.org/) 所启动的开源项目，该项目旨在为 RISC-V 开发者提供一个便捷、完善的开发环境。其提供了相关最新的硬件信息、软件支持，例如针对开发板操作系统支持情况的 [操作系统支持矩阵](https://github.com/ruyisdk/support-matrix/)；软件层面提供了镜像（如 [RevyOS](https://docs.revyos.dev/)）、[工具链](https://github.com/plctlab)、[包管理器](https://github.com/ruyisdk/ruyi/) 等。

其最终目标是希望为 RISC-V 开发者提供一个完善、便捷的开发环境，使得 RISC-V 成为主流架构，以及建设并运营一个完善的社区以便开发者交流。最终希望 RuyiSDK 可以走向国际化，为全球的 RISC-V 开发者提供开发的便捷。

---
## RISC-V 操作系统支持矩阵

- 绝大多数常见的操作系统 × 开发板组合
    - Linux 发行版 & RTOS 均有覆盖
- 从零开始的系统刷写&启动流程
- 系统可用性验证
- Demo/SDK 验证
- 应用软件生态观测
- 向上游回报测试情况/issue

---

![Linux](https://ruyisdk.github.io/support-matrix/linux.svg)

---

### 以 Milk-V Pioneer 为例

![](../../month16/PLCT_OpenDay_2024/image/2024-08-23-03-01-44.png)

---

![](../../month16/PLCT_OpenDay_2024/image/2024-08-19-05-24-43.png)

---

## 自动化测试框架

现有工具局限：

- 目标板开始测试时并无系统，烧录系统同样是测试内容
- 无法同时操作 ts 和 dut
- 生成报告难以处理——不记录操作过程
- 无法良好处理不同开发板 x 系统的复杂配置
- 无法兼容外设：只为测试软件，不支持采集卡、刷写设备等

---

### 自动化测试工具

#### 硬件

喜报：有新的硬件从社区里长出来了！
- sd-mux：远程刷写目标设备
    - 目前使用的是 [Badgerd SDWireC](https://github.com/Badger-Embedded/badgerd-sdwirec)，Apache-2.0
    - SDWireC 即将推出二代 USB 3.0 版本
    - 现在还有其它设备可选：
        - [sd_swap](https://github.com/Mr-Bossman/SD_Swap)，GPL-2.0 OR MIT，兼容性？，速度++，成本-
        - [Avoata HyperCard](https://docs.avaota.fun/avaota-sbc/avaota-hypercard/hypercard/)，CERN-OHL-P-2.0，兼容性+，速度~，成本--
- IPKVM：控制设备，捕获输出（无 SSN/VNC/UART Serial 等情况）
    - Sipeed NanoKVM（基本上开箱即用）
    - JetKVM（最近的新众筹项目，暂时观望中；国内购买可能会有困难）

---

#### 软件

- earlytest：早期启动支持：刷写、boot、远程命令行
- autotest：类 openQA 支持的软件测试，GUI 测试，支持 Python、JS 等更新更方便的语言
- lintestor：发行版、软件包测试

---

### lintestor: RISC-V 软件包支持情况矩阵自动化测试工具

#### 简介

- 基于 Rust 的自动化测试系统
- 设计上支持多发行版，目前主要针对 Debian 软件包（Bianbu 实机测试尝试中）
- 目标：提供一个类似 tarsier-meta/report/info.md 的可用性矩阵
- Github: [255doesnotexist/lintestor](https://github.com/255doesnotexist/lintestor)

---

#### 必要性

- 各发行版软件包在 RISC-V 环境下的可用性能提供一个基本了解
- 希望能接续 isrc-cas/tarsier-meta 中的包可用状态部分
- 希望自动化 RISC-V 平台上的不同发行版的不同软件包的测试流程，直接提供大概可用性的一个矩阵

---

#### 功能特性

1. 支持多发行版（设计上支持，目前主要是 Debian）
2. 自动管理 RISC-V 测试环境（QEMU 虚拟机启停）
3. 生成 Markdown 格式的测试结果矩阵
4. 支持跳过特定包的测试
5. 本地测试选项（`--locally` 参数）

---

#### 结果矩阵示例

| 软件包 | 种类 | debian |
|:------|:-----| :-------|
| apache | Web Server | ✅ apache-2.4.62-1 |
| clang | Compiler | ✅ clang-version |
| docker |  | ❓ |
| erlang | Programming Language | ✅ erlang-1:25.3.2.12+dfsg-1 |
| gcc | Toolchain | ✅ gcc-14.2.0 |
| gdb | Debugger | ✅ gdb-15.1-1 |

- ……

---

#### 单软件包测试结果格式

```json
{
    "distro": "debian",
    "os_version": "Linux version 6.9.9-riscv64 (debian-kernel@lists.debian.org) (riscv64-linux-gnu-gcc-13 (Debian 13.3.0-1) \
13.3.0, GNU ld (GNU Binutils for Debian) 2.42.50.20240710) #1 SMP Debian 6.9.9-1 (2024-07-13)",
    "kernel_version": "6.9.9-riscv64",
    "package_name": "apache",
    "package_type": "Web Server",
    "package_version": "2.4.62-1",
    "test_results": [
        {
            "test_name": "Apache Service Test",
            "passed": true
        }
    ],
    "all_tests_passed": true
}

```

---

#### 遇到的挑战

- 部分软件包完整 autopkgtest 测试项庞杂、笨重费时，又有部分软件包并未附带 autopkgtest，且有发行版局限性，最终未采用此种方式测试
- 图形化测试编写、校验有困难
- 测试结果可能不够健壮

---

# 未来

> Life is too short for manual testing! - OpenQA

> ~~(Anything more than once)~~

---

- 添加对更多设备的观测
- 把「应用软件生态观测」融合进「操作系统支持矩阵」项目中
- Contribution Guide ~~（天呐我们怎么会忘记了这个）~~
- 继续改进现有的自动化测试工具，并与 RuyiSDK 其他组件加强协作
    - 已经安排上的部分：ruyi packages-index sync bot
    - 还在画大饼的部分：硬件自动化 CI

---

# ~~广告环节~~

## 我们需要更多勇士！

### J129 RISC-V 开发板软件生态联合观测实习生【甲辰计划联合实习生培养】

Link: https://github.com/rv2036/weloveinterns

---

# 感谢大家！

#### Any questions?

###### 致谢：测试团队的各位小伙伴们，以及所有为 support-matrix 项目直接/间接做过贡献的好心人们 :)

GitHub: https://github.com/ruyisdk/support-matrix