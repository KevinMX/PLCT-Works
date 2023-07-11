---
marp: true
theme: default
footer: 'TARSIER 第三测试小队 郑景坤 / [Kevin.MX](https://gitee.com/KevinMX)'
paginate: true
size: 16:9
---

# openEuler RISC-V 23.03 测试策略与结果同步

报告人：TARSIER 第三测试小队 郑景坤

---

## 背景情况

- RISC-V 计划 23.09 合入 openEuler 主线支持
- 23.03 的基础测试和特性测试已基本完成
- 当前的测试策略将作为 23.09 测试策略的参考
- 目前测试以 QEMU 8.0.2 为主

---

## 基础测试

性能 + 编译器 + 内核 + 长稳 + 功能/DFX（mugen BaseOS）

- 整体与 sig-QA 保持一致，部分项目挂起中。
- 基础测试部分软件包为直接从软件源获取安装，而非直接编译。
- 测试平台以 QEMU 为主，在部分开发板上进行了测试。

目前已知缺陷：

<style scoped>
table {
  font-size: 19px;
}
</style>
| ID                                                         | 缺陷内容                                        | 状态 |
|------------------------------------------------------------|---------------------------------------------|------|
| [I7II91](https://gitee.com/openeuler/RISC-V/issues/I7II91) | 23.03 QEMU LTP 内核测试有失败项                 | Open |
| [I7IIBH](https://gitee.com/openeuler/RISC-V/issues/I7IIBH) | 23.03 QEMU trinity 内核测试不通过               | Open |
| [I7IIDI](https://gitee.com/openeuler/RISC-V/issues/I7IIDI) | 23.03 QEMU LTP Stress 长稳测试不通过            | Open |
| [I7IIR5](https://gitee.com/openeuler/RISC-V/issues/I7IIR5) | 23.03 QEMU csmith 和 yarpgen 编译器测试耗时过久 | Open |

---

### 内核测试

- LTP：有部分 Fail 项。
- Trinity：会导致内核软死锁，未通过。

> 目前 QEMU 和不同开发板均使用不同的内核。(据悉原因为不同厂商适配内核版本不同，暂时无法由 openEuler sig-RISC-V 解决)

> x86_64 平台有部分 QEMU 不可通过的测试在实机可通过。

---

### 编译器测试

#### AnghaBench

Total: 1044021, Passed: 1042280, Failed: 1741, 通过率 99.83% 

##### 失败原因

- 非 RISC-V 架构的内联汇编
- 不支持 RISC-V 平台的条件编译
- 样例代码缺陷（使用了不标准的语法或存在未定义的类型）

---

#### jotai

Total: 36312, Passed: 35666, Failed: 646, 通过率 98.22%

##### 失败原因

- 命名冲突：测试代码中的枚举或符号在系统头文件中已经定义为宏或以不同的类型声明过了。
- 类型定义冲突：测试代码中的存在对 `uint16_t` 等类型的定义，但是与系统 libc 的定义不同。
- 平台相关代码：测试代码中存在对架构相关的预定义宏的使用，然而 RISC-V 架构不被包含在可识别的列表中。
- 未定义的符号：代码中使用的符号/宏未定义。

所有错误均与编译器本身无关，部分错误和架构相关，属于预期结果。

---

#### dejagnu

| 编译器   | 预期通过 | 预期失败 | 无法解析 | 不支持 | 非预期通过 | *非预期失败* | 通过率 |
|----------|----------|----------|----------|--------|------------|--------------|--------|
| gcc      | 112127   | 671      | 22       | 2078   | 3          | 38           | 97.55% |
| g++      | 180847   | 863      | 0        | 8384   | 0          | 27           | 95.12% |
| gfortran | 53641    | 220      | 0        | 99     | 0          | 130          | 99.17% |

筛选了与 x86_64 不同的非预期失败问题，e.g.

`cc1: warning: '-fprefetch-loop-arrays' not supported for this target`

编译器输出的 `warning` 与 `dejagnu` 预期输出不符被判定为失败，非编译器本身问题。部分错误和架构相关，属于预期结果。

---

### 要求百万级测试用例的编译器测试

RISC-V 平台目前执行测试较为缓慢，执行百万量级不现实，暂时挂起中。

#### csmith

未做并行化处理的情况下，100 个测试用例耗时 112 分钟，全部通过。

#### yarpgen

200 个测试用例全部通过。

---

#### LLVMCase

- 无法直接按照 [openEuler社区测试能力执行指南](https://gitee.com/openeuler/QA/blob/master/openEuler%E7%A4%BE%E5%8C%BA%E6%B5%8B%E8%AF%95%E8%83%BD%E5%8A%9B%E6%89%A7%E8%A1%8C%E6%8C%87%E5%8D%97/openEuler%E7%A4%BE%E5%8C%BA%E6%B5%8B%E8%AF%95%E8%83%BD%E5%8A%9B%E6%89%A7%E8%A1%8C%E6%8C%87%E5%8D%97.md#102llvmcase) 执行。
- 构建 LLVM 本身的过程实际上是用 GCC 的，OBS 已有对应构建。
- OBS 构建状态成功 = LLVM Case 通过

[OBS LLVM 项目](https://build.tarsier-infra.com/package/show/openEuler:23.03/llvm)

---
### 基础性能测试

#### fio + libMicro + lmbench + netperf + stream + unixbench

---

#### fio

- 采用全志 D1 的两块开发板暂时无法运行 `fio`。
- 由于开发板多采用 microSD 卡作为存储介质，测试文件大小调小至 1GB。

#### libMicro

- 结果未见异常。

---

#### lmbench

- 需要修改 `scripts/gnu-os`，添加：

```bash
+    riscv*:Linux:*:*)
+        echo ${UNAME_MACHINE}-unknown-linux-gnu
+        exit 0 ;;
```

测试完成，中途有报错，不影响结果。

---

#### netperf

- 测试环境：QEMU 多节点的 VDE 网络。
- 仅测试 QEMU，未在 RISC-V 开发板上进行测试。
- 结果未见异常。

#### stream

- 与 QA 文档相同，直接编译安装。
- 结果未见异常。

---

#### unixbench

- 结果未见异常。
- 需要使用 GitHub 主线版本，否则可能出现 CPU 数量识别错误（不影响结果）。

| QEMU  | NezhaD1 | LicheeRVD1 | Unmatched | VisionFive1 | VisionFive2 |
|-------|---------|------------|-----------|-------------|-------------|
| 230.4 | 104.1   | 103.1      | 733.8     | 367.8       | 1318.1      |

---

### 长稳测试 / LTP Stress

- 内核日志中有 `signal 7` 和 `signal 11` 报错，主要出在内存相关测试项。系统未出现锁死等状况，其他功能不受影响。

```log
[95802.368928] mmap16[1690602]: unhandled signal 7 code 0x2 at 0x00ffffff9ac81400 in mmap16[10000+2a000]
[95802.370204] CPU: 3 PID: 1690602 Comm: mmap16 Not tainted 6.1.19-2.oe2303.riscv64 #1
[95802.371380] Hardware name: riscv-virtio,qemu (DT)
[95802.371905] epc : 0000000000014bf0 ra : 0000000000014bc4 sp : 00ffffffce4c1e00
[95802.372846]  gp : 000000000003c340 tp : 00ffffff9ac7b3c0 t0 : 00000000000047c8
[95802.373825]  t1 : 0000000000000062 t2 : 000000000003ba40 s0 : 0000000000001000
[95802.375248]  s1 : 0000000000030000 a0 : 0000000000000000 a1 : 0000000000000000
[95802.376624]  a2 : 0000000000000000 a3 : 0000000000000061 a4 : 00ffffff9ac81400
[95802.377369]  a5 : 00ffffff9ac82000 a6 : 0000000000000062 a7 : 0000000000000062
[95802.377918]  s2 : 0000000000002000 s3 : 00ffffff9ac81000 s4 : 0000000000000003
[95802.378789]  s5 : 00ffffff9ac81000 s6 : 0000000000000003 s7 : 0000000000000000
[95802.380529]  s8 : 0000000000000028 s9 : 0000000000000068 s10: 0000000000000005
[95802.381159]  s11: 000000000000003f t3 : 00ffffff9abc6554 t4 : 00ffffff9ac7a530
[95802.381462]  t5 : 00ffffff9aae7adc t6 : 0000000000000003
[95802.381960] status: 0000000200004020 badaddr: 00ffffff9ac81400 cause: 000000000000000f
```

---

## 特性测试

- 硬件适配与系统镜像（QEMU&开发板）
- 桌面（UKUI, DDE, Xfce, GNOME, Kiran, Cinnamon）
- 桌面应用（Firefox, Chromium, LibreOffice, GIMP）
- 容器（Docker, iSulad, etc）
- k8s（kubernetes, kubeOS, KubeSphere, k3s）
- 内存管理（etmem）
- 内核（kernel, kconfigDetector）
- Web 服务（OpenResty）
- 数据库（MySQL）
- 编译器（BishengJDK/OpenJDK）
- 其它

---

## 已知缺陷列表

<style scoped>
table {
  font-size: 14px;
}
</style>

| ID                                                         | 缺陷内容                                                    | 状态        |
|------------------------------------------------------------|-----------------------------------------------------------|-------------|
| [I70JPM](https://gitee.com/openeuler/RISC-V/issues/I70JPM) | 使用 D1 SoC 的开发板上 fio 无法正常运行                     | Open        |
|                                                            | A-Ops 无法启动（依赖缺失）                                    |             |
| [I6R8CR](https://gitee.com/openeuler/RISC-V/issues/I6R8CR) | A-Tune 无法启动                                             | Open        |
| [I722L5](https://gitee.com/openeuler/RISC-V/issues/I722L5) | A-tuned 启动失败（golang plugin 机制 支持 riscv 有缺陷）      | Open        |
| [I6V7C0](https://gitee.com/openeuler/RISC-V/issues/I6V7C0) | etmem 无法使用                                              | Open        |
| [I6TI4U](https://gitee.com/openeuler/RISC-V/issues/I6TI4U) | licheePi rv dock 启动 chromium 无法显示                     | Open        |
| [I6TH5M](https://gitee.com/openeuler/RISC-V/issues/I6TH5M) | unmatched 使用 lightdm 启动 GNOME 报错                      | Open        |
| [I6TH5H](https://gitee.com/openeuler/RISC-V/issues/I6TH5H) | unmatched gdm 报错                                          | Open        |
| [I6TH5E](https://gitee.com/openeuler/RISC-V/issues/I6TH5E) | unmatched 打开 firefox 卡死                                 | Open        |
| [I6TMB6](https://gitee.com/openeuler/RISC-V/issues/I6TMB6) | Allwinner D1 Nezha 启动 firefox 失败：Illegal instruction    | Open        |
| [I6TVV6](https://gitee.com/openeuler/RISC-V/issues/I6TVV6) | kubekey部署 KubeSphere 集群失败                             | Open/待重测 |
| [I6TFXV](https://gitee.com/openeuler/RISC-V/issues/I6TFXV) | vision five安装ukui桌面，进入桌面，两个画面循环显示           | Open        |
| [I6RR83](https://gitee.com/openeuler/RISC-V/issues/I6RR83) | pkgship安装elasticsearch失败                                | Open        |
| [I6RR6R](https://gitee.com/openeuler/RISC-V/issues/I6RR6R) | pkgship服务启动失败                                         | Open        |
| [I6R07N](https://gitee.com/openeuler/RISC-V/issues/I6R07N) | secpaver 无法使用                                           | Open        |
| [I6QVV6](https://gitee.com/openeuler/RISC-V/issues/I6QVV6) | cinnamon 默认文件系统无法使用                               | Open        |
| [I6QV8A](https://gitee.com/openeuler/RISC-V/issues/I6QV8A) | cinnamon 的 panel 中固定的软件无法打开                      | Open        |
| [I6QUT1](https://gitee.com/openeuler/RISC-V/issues/I6QUT1) | cinnamon 左下角 menu 部分图标点击无反应                     | Open        |
| [I6QV1V](https://gitee.com/openeuler/RISC-V/issues/I6QV1V) | cinnamon 无法使用回收站                                     | Open        |
| [I6QRDS](https://gitee.com/openeuler/RISC-V/issues/I6QRDS) | 23.02-V1-xfce 在 unmatched 黑屏                             | Open/待重测 |
| [I6STA0](https://gitee.com/openeuler/RISC-V/issues/I6STA0) | licheePI rv dock 无法启动 libreoffice                       | Open        |
| [I6OZ5N](https://gitee.com/openeuler/RISC-V/issues/I6OZ5N) | Kiran桌面关机时的异常行为                                   | Open        |
| [I6OYL4](https://gitee.com/openeuler/RISC-V/issues/I6OYL4) | 在桌面环境中打开 FFADO Mixer 提示无法与 FFADO DBUS 进行通信 | Open        |
| [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY) | gnome 缺陷：gnome-control-center 启动报错                    | Open        |
| [I7FQJV](https://gitee.com/openeuler/RISC-V/issues/I7FQJV) | 23.03 oncn-bwm 无法开启带宽管理                             | Open        |

---

### 硬件适配与系统镜像

| 名称         | 系统安装文档 | 已测试 | 测试用例 | SIG 组     |
|--------------|--------------|--------|----------|------------|
| D1 开发板    | Y            | Y      | Y        | sig-RISC-V |
| LicheeRV     | Y            | Y      | Y        | sig-RISC-V |
| Unmatched    | Y            | Y      | Y        | sig-RISC-V |
| Visionfive 1 | Y            | Y      | Y        | sig-RISC-V |
| Visionfive 2 | Y            | Y      | Y        | sig-RISC-V |
| QEMU         | Y            | Y      | Y        | sig-RISC-V |

---

### 桌面

<style scoped>
table {
  font-size: 15px;
}
</style>

| 名称     | 说明                                                                         | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                                                                                                                                                                                                                                                                                                                              | 特性质量评估** | SIG 组            |
|----------|----------------------------------------------------------------------------|----------|----------|--------|----------|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|-------------------|
| UKUI     | 较为卡顿，需要 GPU 的部分窗口特效可能无法启动(TODO)，QEMU 下需要指定 sv39 页表 | Y        | Y        | Y      | Y        | Y               | [I6TGR9](https://gitee.com/openeuler/RISC-V/issues/I6TGR9) [I6O31D](https://gitee.com/openeuler/RISC-V/issues/I6O31D) [I6Q24G](https://gitee.com/openeuler/RISC-V/issues/I6Q24G) [~~I6Q27C~~](https://gitee.com/openeuler/RISC-V/issues/I6Q27C)                                                                                                                     | ▲              | sig-UKUI          |
| DDE      | 需要手动选择 DDE Session 启动，QEMU 下需要指定 sv39 页表                      | Y        | Y        | Y      | Y        | Y               | [I6VGN4](https://gitee.com/openeuler/RISC-V/issues/I6VGN4)                                                                                                                                                                                                                                                                                                          | ▲              | sig-DDE           |
| xfce     | 镜像自带，QEMU 下需要指定 sv39 页表                                           | Y        | Y        | P      | P        | Y               |                                                                                                                                                                                                                                                                                                                                                                     | ▲              | xfce              |
| GNOME    | QEMU 下需要指定 sv39 页表                                                    | Y        | \*       | P      | P        | Y               | [I6QETO](https://gitee.com/openeuler/RISC-V/issues/I6QETO) [I6QETK](https://gitee.com/openeuler/RISC-V/issues/I6QETK) [I6QETA](https://gitee.com/openeuler/RISC-V/issues/I6QETA) [I6QET6](https://gitee.com/openeuler/RISC-V/issues/I6QET6) [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY?from=project-issue#note_17078724_link)                        | ▲              | GNOME             |
| Kiran    | QEMU 下需要指定 sv39 页表                                                    | Y        | Y        | Y      | Y        | Y               | [I6OZ5N](https://gitee.com/openeuler/RISC-V/issues/I6OZ5N) [I6OYL4](https://gitee.com/openeuler/RISC-V/issues/I6OYL4) [I6WHYU](https://gitee.com/openeuler/RISC-V/issues/I6WHYU)                                                                                                                                                                                    | ▲              | sig-KIRAN-DESKTOP |
| Cinnamon | 绝大部分应用从桌面无法直接启动，QEMU 下需要指定 sv39 页表                     | Y        | \*       | Y      | Y        | Y               | [I6QV1V](https://gitee.com/openeuler/RISC-V/issues/I6QV1V?from=project-issue) [I6QUT1](https://gitee.com/openeuler/RISC-V/issues/I6QUT1?from=project-issue) [I6QV8A](https://gitee.com/openeuler/RISC-V/issues/I6QV8A?from=project-issue) [~~I6QVEN~~](https://gitee.com/openeuler/RISC-V/issues/I6QVEN) [I6QVV6](https://gitee.com/openeuler/RISC-V/issues/I6QVV6) | ●              | sig-cinnamon      |

---

### 桌面应用

| 名称        | 说明 | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues | 特性质量评估** |
|-------------|------|----------|----------|--------|----------|-----------------|--------|----------------|
| Firefox     |      |          |          |        |          | Y               |        | ▲              |
| Chromium    |      |          |          |        |          | Y               |        | ▲              |
| LibreOffice |      |          |          |        |          | Y               |        | ▲              |
| GIMP        |      |          |          |        |          | Y               |        | ▲              |

---

### 容器

<style scoped>
table {
  font-size: 15px;
}
</style>

| 名称                                      | 说明                                                                                                                                                                                                                                        | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                                                                                                                                                                                                                                                                 | 特性质量评估** | SIG 组          |
|-------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|----------|--------|----------|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|-----------------|
| 容器(isula/docker/安全容器/系统容器/镜像) | 见 [I6QQLB](https://gitee.com/openeuler/iSulad/issues/I6QQLB) 有 iSulad sig 官方的黑盒测试工具；iSulad新增native network 特性                                                                                                                | Y        | Y        | Y      | Y        | P               | [I6R1UT](https://gitee.com/openeuler/RISC-V/issues/I6R1UT) [I6R9OQ](https://gitee.com/openeuler/RISC-V/issues/I6R9OQ) [I6RDWA](https://gitee.com/openeuler/RISC-V/issues/I6RDWA) [I6RSAC](https://gitee.com/openeuler/RISC-V/issues/I6RSAC) [I6R5DH](https://gitee.com/openeuler/RISC-V/issues/I6R5DH) | ▲              | iSulad          |
| HA/高可用                                 | 仅安装成功                                                                                                                                                                                                                                  | Y        | Y        | N      | Y        | Y               |                                                                                                                                                                                                                                                                                                        |                | sig-Ha          |
| eggo                                      | 软件包存在，可安装，未测试                                                                                                                                                                                                                    | \*       | \*       | N      | N        | Y               |                                                                                                                                                                                                                                                                                                        |                | sig-CloudNative |
| 虚拟化 Virt                               | 优先级低，目前市面上尚无支持虚拟化的 RISC-V 硬件；openEuler 目前暂未实现，有虚拟化测试框架 avicado-vt，当前状态：[avocado-vt test on openEuler-riscv](https://gitee.com/lvxiaoqian/memo/blob/master/avocado-vt%20test%20on%20openEuler-riscv.md) | Y        | \*       | N      | N        | Y               |                                                                                                                                                                                                                                                                                                        |                | sig-Virt        |

---

### 内存管理

<style scoped>
table {
  font-size: 19px;
}
</style>

| 名称  | 说明     | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                     | 特性质量评估** | SIG 组  |
|-------|--------|----------|----------|--------|----------|-----------------|------------------------------------------------------------|----------------|---------|
| etmem | 启动失败 | \*       | \*       | N      | N        | Y               | [I6V7C0](https://gitee.com/openeuler/RISC-V/issues/I6V7C0) | ×              | Storage |

---

### 内核

针对内核本身的测试已包含在基础测试中。

<style scoped>
table {
  font-size: 19px;
}
</style>

| 名称            | 说明                        | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                     | 特性质量评估** | SIG 组 |
|-----------------|---------------------------|----------|----------|--------|----------|-----------------|------------------------------------------------------------|----------------|--------|
| kconfigDetector | OBS 已有且构建成功，暂未进源 | Y        | Y        | Y      | Y        | Y               | [I6V7CP](https://gitee.com/openeuler/RISC-V/issues/I6V7CP) | █              |        |

---

### Web 服务

| 名称      | 说明 | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues | 特性质量评估** | SIG 组        | 负责人 |
|-----------|------|----------|----------|--------|----------|-----------------|--------|----------------|---------------|--------|
| OpenResty |      | Y        | Y        | N      | Y        | Y               |        |                | sig-OpenResty |        |

---

### 数据库 / MySQL

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      49      |   48   |   1    |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/MYSQL)

---

### 编译器

<style scoped>
table {
  font-size: 19px;
}
</style>

| 名称               | 说明                                                                                                         | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues | 特性质量评估** | SIG 组   |
|--------------------|------------------------------------------------------------------------------------------------------------|----------|----------|--------|----------|-----------------|--------|----------------|----------|
| GCC                | gcc 在基础测试中已完成; GCC编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能 （未测试）             | P        | \*       | Y      | Y        | Y               |        | █              | Compiler |
| 毕昇 JDK / OpenJDK | JDK 官方回归测试套件 jtreg 需要自行编译执行，上游和 oErv 源均不提供，目前已完成 Bisheng JDK 11 & OpenJDK 17/19 | Y        |          | Y      | Y        | Y               |        | ▲              |          |

---

### 其它

<style scoped>
table {
  font-size: 9px;
}
</style>

| 名称                               | 说明                                                                                                                                                                                                          | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                                                                                | 特性质量评估** | SIG 组                       |
|------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|----------|--------|----------|-----------------|-----------------------------------------------------------------------------------------------------------------------|----------------|------------------------------|
| A-Tune                             | 无法启动                                                                                                                                                                                                      | Y        | Y        | N      | Y        | Y               | [I6R8CR](https://gitee.com/openeuler/RISC-V/issues/I6R8CR?from=project-issue)                                         | ×              | A-Tune                       |
| secPaver                           | oErv 不支持 SELinux，暂无法使用                                                                                                                                                                                | Y        | \*       | Y      | Y        | Y               |                                                                                                                       | ×              | sig-security-facility        |
| secGear                            | 缺依赖 penlaisdk                                                                                                                                                                                              | \*       | \*       | N      | N        | N               |                                                                                                                       | ×              | sig-confidential-computing   |
| openGauss                          | 不支持                                                                                                                                                                                                        | \*       | \*       | N      | N        | N               |                                                                                                                       | ×              | DB                           |
| 用户态协议栈 gazelle               | 缺包，不支持                                                                                                                                                                                                   | \*       | \*       | N      | N        | N               |                                                                                                                       | 0              | sig-high-performance-network |
| 容器场景在离线混合部署 rubik       | 缺包，不支持                                                                                                                                                                                                   | \*       | \*       | N      | N        | N               |                                                                                                                       | 0              | sig-CloudNative              |
| A-ops                              | 部分依赖组件如 elasticsearch 不支持 RISC-V                                                                                                                                                                    | Y        | \*       | Y      | N        | Y               |                                                                                                                       |                | sig-ops                      |
| IO 智能多流 astream                | 依赖支持多流特性 SSD                                                                                                                                                                                          | Y        | \*       | N      | N        | Y               |                                                                                                                       |                |                              |
| pkgship                            | 有 redis 但 ElasticSearch 目前不支持 rv64，依赖不全无法启动                                                                                                                                                    | Y        | \*       | Y      | Y        | P               | [I6RR6R](https://gitee.com/openeuler/RISC-V/issues/I6RR6R) [I6RR83](https://gitee.com/openeuler/RISC-V/issues/I6RR83) | 0              | sig-EasyLife                 |
| ROS/ROS2                           | ROS 2 porting 进行中                                                                                                                                                                                          | N        | N        | N      | N        |                 |                                                                                                                       |                | sig-ROS                      |
| 虚拟机热迁移                       | [QEMU 文档](https://www.qemu.org/docs/master/devel/migration.html)；[openEuler 文档](https://docs.openeuler.org/zh/docs/23.03/docs/Virtualization/%E7%83%AD%E8%BF%81%E7%A7%BB%E8%99%9A%E6%8B%9F%E6%9C%BA.html) |          |          |        |          |                 |                                                                                                                       |                | Virt                         |
| 虚拟化热补丁libcareplus            | TODO: 官方测试工具；**可能需要针对 RISC-V 平台本身的一些特性进行测试**（e.g. ELF 重定位类型）                                                                                                                    | Y        | Y        | Y      | Y        | Y               |                                                                                                                       | █              | sig-Virt                     |
| 定制裁剪工具(imageTailor和oemaker) | 需要测试：目前不支持，后续如有发版生成镜像需要会做                                                                                                                                                              |          |          |        |          |                 |                                                                                                                       |                | sig-OS-Builder               |
| 国密算法                           | 需要测试，SM2/3/4 目前已加入内核 Kconfig                                                                                                                                                                       |          |          |        |          |                 |                                                                                                                       |                | sig-security-facility?       |
| libstorage 针对 NVME 的 IO 栈      | 目前仅测试 libstorage 非 NVME 部分                                                                                                                                                                            | \*       | \*       | P      | N        |                 |                                                                                                                       |                | ?                            |

---

## 测试执行 —— 测试阶段 1

- 继承特性/新特性的基本功能 
    -> 特性测试
- 交付重要组件（内核、虚拟化、容器、编译器等）的功能完整性
    -> 基础测试 & 特性测试
- 系统集成方面保证多组件多模块集成的正确性和整体系统的完整性
- 通过软件包管理测试，对发布软件的可安装进行整体保证（CI 门禁）
- 专项测试：
    - 性能：保证版本的性能满足发布基线标准，不能低于版本性能指标（基础性能测试）
    - 南向兼容性验证：硬件开发板 -> 特性支持

--- 

## 测试执行 —— 测试阶段 2

- 继承特性/新特性的全量验证
- 通过自动化覆盖重要组件的功能
- 系统集成的正确性和完整性
- 软件包管理测试
- 专项测试：
    - 可靠性：保证版本的长时间稳定运行，建议运行时长 7*24 （LTP Stress）
    - 软件包 fuzz 测试

---

## 测试执行 —— 测试阶段 3

- 继承特性/新特性的自动化全量验证
- 系统集成验证
- 软件包管理测试
- 专项：性能、可靠性、文档测试
- 问题单回归

---

## 测试执行 —— 测试阶段 4

- 交付特性/组件的全量测试
- 问题单回归
- 软件包管理测试
- 系统集成测试
- 专项测试：
    - 可靠性
    - 性能
    - 文档

---

## 测试执行 —— 测试阶段 5

- 交付特性/组件的自动化全量测试
- 系统集成自动化测试项执行
- 问题单全量回归
- 专项测试：
    - 文档测试