
**修订记录**
| 日期       | 修订版本 | 修改描述           | 作者              |
| ---------- | -------- | ------------------ | ----------------- |
| 2023-06-21 | 0.0.1    | Demo               | KevinMX; 桜風の狐 |
| 2023-06-24 | 0.0.2    | 格式更改和文档汇总 | 桜風の狐          |

**表格图例**

\*: 可参考上游官方文档补全。

\*\*: 与 sig-QA 的质量评估标准同步。

●：表示特性不稳定，风险高。

▲：表示特性基本可用，遗留少量问题。

█：表示特性质量良好。

×：特性不可用/不支持 RISC-V。

N/A：不适用评估标准。

# 目录

+ 摘要
+ 工作内容
   + 建立测试环境
   + 进行软件遴选
   + 产出人工测试用例
   + 运行测试
+ 硬件适配与系统镜像
   + 需求清单
   + D1 开发板
   + LicheeRV
   + Unmatched
   + Visionfive 1
   + Visionfive 2
+ 桌面
   + 需求清单
   + UKUI
   + DDE
   + xfce
   + GNOME
   + Kiran
   + Cinnamon
   + 新增备份还原功能支持
+ 桌面应用
   + 需求清单
   + Firefox
   + Chromium
   + Thunderbird
   + LibreOffice
   + VLC
   + GIMP
+ 容器
   + 需求清单
   + Docker
   + iSulad
   + 安全容器
   + 容器镜像构建
   + 系统容器
   + HA/高可用
   + OpenStack Train & Wallaby
   + eggo
   + NestOS
   + 虚拟化 Virt
+ k8s 相关
   + 需求清单
   + kubernetes
   + kubeOS
   + KubeSphere
   + k3s
+ 内存管理
   + 需求清单
   + etmem
+ 内核
   + 需求清单
   + kernel
   + kconfigDetector
+ Web 服务
   + 需求清单
   + OpenResty
+ 数据库
   + 需求清单
   + Mysql
+ 编译器
   + 需求清单
   + jdk
   + 毕昇 JDK
+ 其他
   + 需求清单
   + A-Tune
   + secPaver
   + secGear
   + openGauss
   + 用户态协议栈 gazelle
   + 容器场景在离线混合部署 rubik
   + A-ops
   + IO 智能多流
   + pkgship
   + mindspore
   + pod 带宽管理 oncn-bwm
   + ROS/ROS2
   + 高性能服务网格数据面 Kmesh
   + 虚拟机热迁移
   + 虚拟化热补丁 libcareplus
   + 定制裁剪工具 (imageTailor和oemaker)
   + 国密算法
   + libstorage 针对 NVME 的 IO 栈

# 摘要

openEuler 是一款开源操作系统。当前 openEuler 内核源于 Linux ，支持多种处理器架构，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。 openEuler RISC-V 广泛支持国内外 RISC-V 架构处理器，适配全志 D1 、 Sipeed LicheeRV 、 HiFive Unmatched 、 StarFive VisionFive 等多款开发板。

本文主要描述 openEuler RISC-V 23.03 版本特性测试策略，展现现阶段测试成果，并为开展进一步测试工作提供一份相对完整的文档。特性测试按照 DFX 测试范围，利用测试用例库中的人工测试方法，基于遴选成功打包的软件，搭建测试环境并测试安装、卸载以及基本功能实现，得到测试结果，产出测试报告。

**关键词**：特性测试，人工测试，RISC-V

# 工作内容

本章主要完成了软件遴选并产出测试用例，使用测试用例在测试环境下执行人工特性测试。尽管本章给出了一些具体的测试环境参数，但是后文中给出的测试结果并不一定是在这样的测试环境下得出的。

## 建立测试环境

周嘉诚提供可用于运行在测试用开发板和 Qemu 环境下测试的镜像 [release](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/release.md) ，软件源使用镜像默认的软件源， Qemu 版本选用 8.0.0+ 。

## 进行软件遴选

从 openEuler 23.03 [版本测试策略](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_23.03/openEuler%2023.03%20%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E7%AD%96%E7%95%A5.md) 选取上游社区的重点测试组件中（新增、继承）遴选 RISC-V 版本已支持和可支持的组件。

测试 openEuler RISC-V 最新源是否有相关包，并验证安装、卸载和基本功能可用，并制作安装文档和使用文档。如 openEuler RISC-V 最新源没有相关包，直接使用上游或下游（UKUI）源码打包。若打包成功，产出构建文档和资源。若打包失败，产出缺陷 Issue，包括失败日志和缺包清单提交到 openEuler/RISC-V Issue。

遴选得到的测试范围见 [DFX 测试](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/DFXlist.csv) 。

## 产出测试用例

### 产出人工测试用例

基于遴选成功打包的软件，测试安装、卸载和基本功能，产出为测试用例，应按照 [用例要求](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2FArielHeleneto%2FRISCV-testcase%23%25E7%25BC%2596%25E5%2586%2599%25E8%25A6%2581%25E6%25B1%2582)，提交到 [测试用例库](https://github.com/ArielHeleneto/RISCV-testcase) 新提交大概这里 [这里](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test) 。

发现的缺陷，提交缺陷到 [openEuler/RISC-V Issue](https://gitee.com/openeuler/RISC-V/issues) ，应包括环境、步骤，预期效果、实际效果、截图，失败日志等。

### 编写自动化测试用例（Mugen、openQA）

对形成测试用例的软件，编写自动化测试脚本，界面类使用 openQA ，非界面类使用 [Mugen](https://gitee.com/openeuler/mugen) 。

## 运行测试

硬件适配与系统镜像部分测试使用开发板配套的测试镜像启动开发板后在开发板执行测试用例；其他测试在 Qemu 运行 Qemu 镜像，在 Qemu 虚拟机中运行测试用例，测试环境使用 Qemu 8.0.0+ 时部分测试用例需要指定 sv39 页表。

# 硬件适配与系统镜像

本章主要完成了 openEuler RISC-V 系统镜像对各型号硬件支持程度的测试。测试使用对应硬件适配的 openEuler 镜像，按照各型号开发板附带的说明人工烧写并启动镜像，手动按照测试要求运行测试并记录结果，测试结果整理在仓库 [/Hardware_Test](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/Hardware_Test) 目录下。

硬件相关主要进行测试

+ 系统的刷写和启动
+ Wifi 使用

图形界面主要进行测试

+ Xfce
+ Gnome
+ Kiran
+ UKUI

桌面软件主要进行测试

+ Firefox 桌面启动
+ Firefox 终端启动
+ 从桌面启动 LibreOffice
+ 从终端启动 LibreOffice
+ 从桌面启动 Thunderbird
+ 从终端启动 Thunderbird
+ 从桌面启动 Chromium
+ 从终端启动 Chromium
+ 从桌面启动 GIMP
+ 从终端启动 GIMP
+ 从桌面启动 Sysprof
+ 从终端启动 Sysprof

## 需求清单

| 名称         | 系统安装文档 | 已测试 | 测试用例 | issues | SIG 组     | 负责人 |
| ------------ | ------------ | ------ | -------- | ------ | ---------- | ------ |
| D1 开发板    | Y            | Y      | Y        |        | sig-RISC-V |        |
| LicheeRV     | Y            | Y      | Y        |        | sig-RISC-V |        |
| Unmatched    | Y            | Y      | Y        |        | sig-RISC-V |        |
| Visionfive 1 | Y            | Y      | Y        |        | sig-RISC-V |        |
| Visionfive 2 | Y            | Y      | Y        |        | sig-RISC-V |        |
| QEMU         | Y            | Y      | Y        |        | sig-RISC-V |        |

## D1 开发板

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      14      |   7    |   7    |

#### 通过的测试用例

| 测试用例               | 预期结果             | 实际结果             |
| ---------------------- | -------------------- | -------------------- |
| 系统的刷写和启动       | 系统启动成功         | 系统启动成功         |
| 从桌面启动 Thunderbird | 正常启动 Thunderbird | 正常启动 Thunderbird |
| 从桌面启动 GIMP        | 正常启动 GIMP        | 正常启动 GIMP        |
| 从桌面启动 Sysprof     | 正常启动 Sysprof     | 正常启动 Sysprof     |
| 从终端启动 GIMP        | 正常启动 GIMP        | 正常启动 GIMP        |
| 从终端启动 Sysprof     | 正常启动 Sysprof     | 正常启动 Sysprof     |
| 从终端启动 Thunderbird | 正常启动 Thunderbird | 正常启动 Thunderbird |

#### 失败的测试用例

| 测试用例                      | 预期结果                                        | 实际结果                                       |
| ----------------------------- | ----------------------------------------------- | ---------------------------------------------- |
| Wifi 使用                     | 可以找到无线网卡                                | 无法找到无线网卡                               |
| Firefox 桌面启动              | 正常启动 Firefox 浏览器                         | 正常启动 Firefox 浏览器                        |
| Firefox 终端启动              | 正常启动 Firefox 浏览器                         | 无法正常启动，终端报错 `Illegal instruction` |
| 在 Firefox 观看 Bilibili 视频 | 能正常播放 Bilibili 视频                        | 网页报错，无法打开网页，进而无法进行视频播放   |
| Ping 需要管理员权限           | Ping 指令正常运行                               | Terminal 提示需要管理员权限                    |
| 从终端启动 Chromium           | Chromium 启动成功                               | Chromium 启动失败                              |
| 从终端启动 LibreOffice        | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 | LibreOffice 启动失败，显示加载页面后闪退       |

## LicheeRV

### 测试目的

使用 openEuler 23.03 RISC-V V1 版本镜像，测试其在 LicheeRV 开发板上的安装和基本功能运行是否正常。

### 测试环境信息
|硬件型号|硬件配置信息|
|-|-|
|LicheeRV|CPU：全志 D1 CPU<br>内存：980MiB<br>内存卡容量：32GB|

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      10      |   6    |   4    |

#### 通过的测试用例

| 测试用例           | 预期结果                   | 实际结果                   |
| ------------------ | -------------------------- | -------------------------- |
| 系统的刷写和启动   | 系统启动成功               | 系统启动成功               |
| Wifi 使用          | 正常进行 Wifi 的连接与断开 | 正常进行 Wifi 的连接与断开 |
| 从桌面启动 GIMP    | 正常启动 GIMP              | 正常启动 GIMP              |
| 从桌面启动 Sysprof | 正常启动 Sysprof           | 正常启动 Sysprof           |
| 从终端启动 GIMP    | 正常启动 GIMP              | 正常启动 GIMP              |
| 从终端启动 Sysprof | 正常启动 Sysprof           | 正常启动 Sysprof           |

#### 失败的测试用例

| 测试用例            | 预期结果                                        | 实际结果                                                                                                                                                                                                                                       |
| ------------------- | ----------------------------------------------- | -|
| Ping 权限设置不正确 | ping 指令正常运行                               | ping 报错： `ping: socket: Operation not permitted` |
| 启动 Chromium       | Chromium 启动成功                               | Chromium 启动失败。无法显示界面，但鼠标放到相应位置时，光标有相应变化。[报错 log](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/Hardware_Test/LicheeRV/failed_case/%E5%90%AF%E5%8A%A8Chromium.md#%E6%8A%A5%E9%94%99-log) |
| 启动 Firefox        | 正常启动 Firefox 浏览器                         | 无法启动，报错 ``Illegal instruction``                                                                                                                                                                                                         |
| 启动 LibreOffice    | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 | LibreOffice 启动失败，显示加载页面后闪退                                                                                                                                                                                                       |

## Unmatched

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      18      |   14    |   4    |

#### 通过的测试用例

| 测试用例               | 预期结果                                        | 实际结果                                        |
| ---------------------- | ----------------------------------------------- | ----------------------------------------------- |
| 系统的刷写和启动       | 系统启动成功                                    | 系统启动成功                                    |
| Wifi 使用              | 正常进行 Wifi 的连接与断开                      | 正常进行 Wifi 的连接与断开                      |
| Firefox 桌面启动       | 正常启动 Firefox 浏览器                         | 正常启动 Firefox 浏览器                         |
| Firefox 终端启动       | 正常启动 Firefox 浏览器                         | 正常启动 Firefox 浏览器                         |
| 从桌面启动 LibreOffice | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 |
| 从桌面启动 Thunderbird | 正常启动 Thunderbird                            | 正常启动 Thunderbird                            |
| 从桌面启动 Chromium    | Chromium 启动成功                               | Chromium 启动成功                               |
| 从桌面启动 GIMP        | 正常启动 GIMP                                   | 正常启动 GIMP                                   |
| 从桌面启动 Sysprof     | 正常启动 Sysprof                                | 正常启动 Sysprof                                |
| 从终端启动 GIMP        | 正常启动 GIMP                                   | 正常启动 GIMP                                   |
| 从终端启动 Sysprof     | 正常启动 Sysprof                                | 正常启动 Sysprof                                |
| 从终端启动 Chromium    | Chromium 启动成功                               | Chromium 启动成功                               |
| 从终端启动 LibreOffice | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 |
| 从终端启动 Thunderbird | 正常启动 Thunderbird                            | 正常启动 Thunderbird                            |

#### 失败的测试用例

| 测试用例            | 预期结果                     | 实际结果                                                                                                                                                                                                    |
| ------------------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ping 权限设置不正确 | ping 指令正常运行            | ping 报错 `ping: socket: Operation not permitted`                                                                                                                                                         |
| firefox 启动卡死    | firefox 启动成功             | 系统在 firefox 打开之前卡死，或者 firefox 窗口显示后卡死。 卡死指图形界面、串口和已经连入的 ssh 均无任何响应                                                                                                |
| gdm 启动报错        | gdm 正常打开，显示出登录界面 | gdm 报错[截图](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/Hardware_Test/Unmatched/failed_case/gdm%E5%90%AF%E5%8A%A8%E6%8A%A5%E9%94%99.md#%E5%AE%9E%E9%99%85%E7%BB%93%E6%9E%9C)     |
| gnome 启动报错      | GNOME 正常打开，显示出桌面   | GNOME 报错[截图](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/Hardware_Test/Unmatched/failed_case/gnome%E5%90%AF%E5%8A%A8%E6%8A%A5%E9%94%99.md#%E5%AE%9E%E9%99%85%E7%BB%93%E6%9E%9C) |

## Visionfive 1

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      16      |   15    |   1    |

#### 通过的测试用例

| 测试用例 | 预期结果 | 实际结果 |
| -------- | -------- | -------- |
|系统的刷写和启动|系统启动成功|系统启动成功|
|Wifi 使用|正常进行 Wifi 的连接与断开|正常进行 Wifi 的连接与断开|
|Firefox 桌面启动|正常启动 Firefox 浏览器|正常启动 Firefox 浏览器|
|Firefox 终端启动|正常启动 Firefox 浏览器|正常启动 Firefox 浏览器|
|Kiran 桌面的安装和启动|成功进入桌面|成功进入桌面|
|从桌面启动 LibreOffice|LibreOffice 启动成功，显示 LibreOffice 欢迎页面|LibreOffice 启动成功，显示 LibreOffice 欢迎页面|
|从桌面启动 Thunderbird|正常启动 Thunderbird|正常启动 Thunderbird|
|从桌面启动 Chromium|Chromium 启动成功|Chromium 启动成功|
|从桌面启动 GIMP|正常启动 GIMP|正常启动 GIMP|
|从桌面启动 Sysprof|正常启动 Sysprof|正常启动 Sysprof|
|从终端启动 GIMP|正常启动 GIMP|正常启动 GIMP|
|从终端启动 Sysprof|正常启动 Sysprof|正常启动 Sysprof|
|从终端启动 Chromium|Chromium 启动成功|Chromium 启动成功|
|从终端启动 LibreOffice|LibreOffice 启动成功，显示 LibreOffice 欢迎页面|LibreOffice 启动成功，显示 LibreOffice 欢迎页面|
|从终端启动 Thunderbird|正常启动 Thunderbird|正常启动 Thunderbird|

#### 失败的测试用例

| 测试用例 | 预期结果 | 实际结果 |
| -------- | -------- | -------- |
|安装启动 ukui 桌面|开机进入 ukui 桌面|进入桌面后，鼠标只能移动，点击应用没反应，在如下[两个图](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/Hardware_Test/Visionfive/failed_case/%E5%AE%89%E8%A3%85%E5%90%AF%E5%8A%A8ukui%E6%A1%8C%E9%9D%A2.md#%E5%AE%9E%E9%99%85%E7%BB%93%E6%9E%9C)之间切换|

## Visionfive 2

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      14      |   12    |   2    |

#### 失败的测试用例

| 测试用例             | 预期结果                     | 实际结果                                              |
| -------------------- | ---------------------------- | ----------------------------------------------------- |
| Thunderbird 安装失败 | 成功安装并启动 `Thunderbird` | `Thunderbird` 软件包不存在，安装失败                  |
| ping 执行失败        | `ping` 指令正常运行          | 需要管理员权限才能执行，或者需要重新安装 `iputils` 包 |

#### 通过的测试用例

| 测试用例                      | 预期结果                                        | 实际结果                                        |
| ----------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| 系统的刷写和启动              | 系统启动成功                                    | 系统启动成功                                    | 
| 从桌面启动 Sysprof            | 正常启动 Sysprof                                | 正常启动 Sysprof                                |
| 从终端启动 Sysprof            | 正常启动 Sysprof                                | 正常启动 Sysprof                                |
| 从桌面启动 GIMP               | 正常启动 GIMP                                   | 正常启动 GIMP                                   |
| 从终端启动 GIMP               | 正常启动 GIMP                                   | 正常启动 GIMP                                   |
| 从桌面启动 Chromium           | Chromium 启动成功                               | Chromium 启动成功                               |
| 从终端启动 Chromium           | Chromium 启动成功                               | Chromium 启动成功                               |
| 从桌面启动 LibreOffice        | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 |
| 从终端启动 LibreOffice        | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 | LibreOffice 启动成功，显示 LibreOffice 欢迎页面 |
| Firefox 桌面启动              | 正常启动 Firefox 浏览器                         | 正常启动 Firefox 浏览器                         |
| Firefox 终端启动              | 正常启动 Firefox 浏览器                         | 正常启动 Firefox 浏览器                         |
| 在 Firefox 观看 Bilibili 视频 | 能正常播放 Bilibili 视频                        | 能正常播放 Bilibili 视频                        |

# 桌面

## 需求清单

| 名称     | 说明                                                                           | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                                                                                                                                                                                                                                                                                                                          | 特性质量评估** | SIG 组            | 负责人 |
| -------- | ------------------------------------------------------------------------------ | -------- | -------- | ------ | -------- | --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------- | ------ |
| UKUI     | 较为卡顿，需要 GPU 的部分窗口特效可能无法启动(TODO)，QEMU 下需要指定 sv39 页表 | Y        | Y        | Y      | Y        | Y               | [I6TGR9](https://gitee.com/openeuler/RISC-V/issues/I6TGR9) [I6O31D](https://gitee.com/openeuler/RISC-V/issues/I6O31D) [I6Q24G](https://gitee.com/openeuler/RISC-V/issues/I6Q24G) [~~I6Q27C~~](https://gitee.com/openeuler/RISC-V/issues/I6Q27C)                                                                                                                 | ▲              | sig-UKUI          |        |
| DDE      | 需要手动选择 DDE Session 启动，QEMU 下需要指定 sv39 页表                       | Y        | Y        | Y      | Y        | Y               | [I6VGN4](https://gitee.com/openeuler/RISC-V/issues/I6VGN4)                                                                                                                                                                                                                                                                                                      | ▲              | sig-DDE           |        |
| xfce     | 镜像自带，QEMU 下需要指定 sv39 页表                                            | Y        | Y        | P      | P        | Y               |                                                                                                                                                                                                                                                                                                                                                                 | ▲              | xfce              |        |
| GNOME    | QEMU 下需要指定 sv39 页表                                                      | Y        | \*       | P      | P        | Y               | [I6QETO](https://gitee.com/openeuler/RISC-V/issues/I6QETO) [I6QETK](https://gitee.com/openeuler/RISC-V/issues/I6QETK) [I6QETA](https://gitee.com/openeuler/RISC-V/issues/I6QETA) [I6QET6](https://gitee.com/openeuler/RISC-V/issues/I6QET6) [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY?from=project-issue#note_17078724_link)                    | ▲              | GNOME             |        |
| Kiran    | QEMU 下需要指定 sv39 页表                                                      | Y        | Y        | Y      | Y        | Y               | [I6OZ5N](https://gitee.com/openeuler/RISC-V/issues/I6OZ5N) [I6OYL4](https://gitee.com/openeuler/RISC-V/issues/I6OYL4) [I6WHYU](https://gitee.com/openeuler/RISC-V/issues/I6WHYU)                                                                                                                                                                                | ▲              | sig-KIRAN-DESKTOP |        |
| Cinnamon | 绝大部分应用从桌面无法直接启动，QEMU 下需要指定 sv39 页表      | Y        | \*       | Y      | Y        | Y               | [I6QV1V](https://gitee.com/openeuler/RISC-V/issues/I6QV1V?from=project-issue) [I6QUT1](https://gitee.com/openeuler/RISC-V/issues/I6QUT1?from=project-issue) [I6QV8A](https://gitee.com/openeuler/RISC-V/issues/I6QV8A?from=project-issue) [~~I6QVEN~~](https://gitee.com/openeuler/RISC-V/issues/I6QVEN) [I6QVV6](https://gitee.com/openeuler/RISC-V/issues/I6QVV6) | ●              | sig-cinnamon      |        |

## UKUI

### 软件说明

UKUI 是由麒麟团队开发的一款轻量级的Linux 桌面环境，默认搭载于优麒麟社
区各版本操作系统中，同时支持Ubuntu、Debian、Arch、openEuler 等主流
Linux 发行版。

官网: https://www.ukui.org

### 测试信息

#### 测试对象版本
|软件包名称|软件包版本|
|-|-|
|ukui-menu|3.1.1|
|peony|3.10.0|

#### 测试环境信息
|操作系统版本|Qemu 版本|vcpu|memory|镜像|
|-|-|-|-|-|
|openEuler 23.02 riscv64|8.0.0+|16|32G|[openEuler-23.02-V1-base-qemu-testing.qcow2.zst](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230322/v0.1/QEMU/openEuler-23.02-V1-base-qemu-testing.qcow2.zst)|


### 安装方法

```bash
sudo dnf install ukui
sudo systemctl set-default graphical.target
sudo systemctl start --now graphical.target
```

### 测试内容

使用人工测试的方式，测试 UKUI 登陆界面、菜单、任务栏、文件管理器、桌面功能、设置、系统监视器等功能能否正常工作。

测试共计 60 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|60|60|0|

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/UKUI)

## DDE

### 测试信息

#### 测试对象版本

| Package | Arch | Version | Repo | Total_Size |
| ------- | ---- | ------- | ---- | ---------- |
| DDE | riscv64 | 2020.11.03-4 | mainline | 503 M |

#### 测试环境信息

| 硬件型号  | 版本       | vcpu | memory | 磁盘     | 备注 |
| --------- | ---------- | ---- | ------ | -------- | ---- |
| RISC-V 64 | QEMU 7.2.0 | 8    | 8G     | 7.5G-15G |      |

### 安装方法

```bash
dnf install dde
```

### 测试内容

使用 openEuler 22.03 RISC-V V2 版本镜像，测试 DDE 的安装和基本功能运行是否正常。

使用人工测试的方式，共计 94 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      94      |   85   |   9    |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/DDE)

## xfce

### 测试信息

### 测试对象版本

| Package | Arch | Version | Repo | Total_Size |
| ------- | ---- | ------- | ---- | ---------- |
| XFCE | riscv64 | 4.16.0 | mainline | 184 k |

### 测试环境信息

| 硬件型号  | Qemu 版本  | vcpu | memory | 磁盘     | 备注 |
| --------- | ---------- | ---- | ------ | -------- | ---- |
| RISC-V 64 | QEMU 7.2.0 | 8    | 8G     | 7.5G-15G |      |

### 测试内容

使用 openEuler 22.03 RISC-V V2 版本镜像，测试 XFCE 的安装和基本功能运行是否正常。

使用人工测试的方式，共计 78 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|:------------:|:------:|:------:|
|      78      |   73   |   5    |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/XFCE)

## GNOME

### 软件说明

GNOME 是运行在类 Unix 操作系统中最常用桌面环境。是一个功能完善、操作简单，界面友好，集使用和开发为一身的桌面环境，是 GNU 计划的正式桌面。

从用户的角度看，GNOME 是一个集成桌面环境和应用程序的套件。从开发者的角度看，它是一个应用程序开发框架(由数目众多的实用函数库组成)。即使用户不运行 GNOME 桌面环境，用 GNOME 编写的应用程序也可以正常运行。

GNOME 既包含文件管理器，应用商店，文本编辑器等基础软件，也包含系统采样分析，系统日志，软件工程 IDE，web 浏览器，简洁虚拟机监视器，开发者文档浏览器等高级应用和工具。

### 测试信息

#### 测试对象版本

|软件包名称|软件包版本|
|gnome-control-center|43.2|

#### 测试环境信息

| 操作系统版本       | Qemu 版本   | vcpu | memory | 镜像                                                                                                                                                                                                                                                                                                               |
| ------------------ | ----------- | ---- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| openEuler-23.02 v1 | QEMU: 7.2.0 | 8    | 16GB   | [openEuler-23.02-V1-base-qemu-testing.qcow2.zst](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230322/v0.1/QEMU/openEuler-23.02-V1-base-qemu-testing.qcow2.zst)，可在[中科院软件所镜像站](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230322/v0.1/QEMU/) |

### 安装方法

- 安装 QEMU

  从系统软件仓库或自行编译安装支持视频输出的 QEMU

- 准备系统镜像

  需要用到以下文件

  1. `openEuler-23.02-V1-base-qemu-testing.qcow2.zst` 不带桌面环境的基础系统镜像。
  2. `fw_payload_oe_uboot_2304.bin` 启动用内核
  3. `start_vm.sh` 和 `start_vm_xfce.sh` 启动脚本

#### 启动并登入虚拟机

将上述准备文件存放到统一目录，并进入该目录。执行以下命令

```shell
# 解压得到镜像磁盘文件
zstd -d openEuler-23.02-V1-base-qemu-testing.qcow2.zst
# 为启动脚本添加可执行权限
chmod +x start_vm.sh
# 执行启动脚本，启动虚拟机
./start_vm.sh
```

虚拟机启动时检查终端输出，注意是否有错误信息，待系统启动后可以使用以下命令从 ssh 登录虚拟机，具体端口号可参考启动脚本内容或启动时终端输出。

```shell
ssh root@127.0.0.1 -p12055
```

> 默认 `root` 用户密码为 `openEuler12#$`

#### 安装 GNOME 并新建非 root 用户

使用 root 用户登入虚拟机后执行以下命令安装 GNOME

```shell
# 更新软件源
dnf update
# 安装字体
dnf install dejavu-fonts liberation-fonts gnu-*-fonts google-*-fonts
# 安装 xorg
dnf install xorg-x11-apps xorg-x11-drivers xorg-x11-drv-ati \
	xorg-x11-drv-dummy xorg-x11-drv-evdev xorg-x11-drv-fbdev \
	xorg-x11-drv-libinput xorg-x11-drv-nouveau xorg-x11-drv-qxl \
	xorg-x11-drv-synaptics-legacy xorg-x11-drv-v4l xorg-x11-server-Xephyr \
	xorg-x11-drv-wacom xorg-x11-fonts xorg-x11-fonts-others \
	xorg-x11-font-utils xorg-x11-server xorg-x11-server-utils \
	xorg-x11-server-Xspice xorg-x11-util-macros xorg-x11-utils xorg-x11-xauth \
	xorg-x11-xbitmaps xorg-x11-xinit xorg-x11-xkb-utils
# 安装 GNOME 和其组件
dnf install adwaita-icon-theme atk atkmm at-spi2-atk at-spi2-core baobab \
	abattis-cantarell-fonts cheese clutter clutter-gst3 clutter-gtk cogl dconf \
	dconf-editor devhelp eog epiphany evince evolution-data-server file-roller folks \
	gcab gcr gdk-pixbuf2 gdm gedit geocode-glib gfbgraph gjs glib2 glibmm24 \
	glib-networking gmime30 gnome-autoar gnome-backgrounds gnome-bluetooth \
	gnome-builder gnome-calculator gnome-calendar gnome-characters \
	gnome-clocks gnome-color-manager gnome-control-center \
	gnome-desktop3 gnome-disk-utility gnome-font-viewer gnome-getting-started-docs \
	gnome-initial-setup gnome-keyring gnome-logs gnome-menus gnome-music \
	gnome-online-accounts gnome-online-miners gnome-photos gnome-remote-desktop \
	gnome-screenshot gnome-session gnome-settings-daemon gnome-shell \
	gnome-shell-extensions gnome-software gnome-system-monitor gnome-terminal \
	gnome-tour gnome-user-docs gnome-user-share gnome-video-effects \
	gnome-weather gobject-introspection gom grilo grilo-plugins \
	gsettings-desktop-schemas gsound gspell gssdp gtk3 gtk4 gtk-doc gtkmm30 \
	gtksourceview4 gtk-vnc2 gupnp gupnp-av gupnp-dlna gvfs json-glib libchamplain \
	libdazzle libgdata libgee libgnomekbd libgsf libgtop2 libgweather libgxps libhandy \
	libmediaart libnma libnotify libpeas librsvg2 libsecret libsigc++20 libsoup \
	mm-common mutter nautilus orca pango pangomm libphodav python3-pyatspi \
	python3-gobject rest rygel simple-scan sushi sysprof totem totem-pl-parser \
	tracker3 tracker3-miners vala vte291 yelp yelp-tools \
	yelp-xsl zenity
```

设置启动时配置

```shell
# 设置 gdm 自启动
systemclt enable gdm
# 设置系统默认以图形界面登录
systemctl set-default graphical.target
```

在关机之前配置可登入 GNOME 的非 root 用户

```shell
# 添加名为 sihuan 的用户，-m 参数为同时创建该用户家目录（/home/sihuan）,-G wheel 为将该用户加入 wheel 组
useradd -m -G wheel sihuan
# 根据交互提示设置新用户密码
passwd sihuan
```

针对 QEMU 平台可能出现的无法启动/内核错误，请向启动脚本的 `cmd` 中添加如下内容。注意，需要 QEMU >= 8.0.0。

```bash
-cpu rv64,sv39=on \
```

#### 启动 GNOME 桌面环境

使用 `start_vm_xfce.sh` 脚本启动虚拟机，稍作等待就可以看到 gdm 登入界面。

```bash
chmod +x start_vm_xfce.sh
./start_vm_xfce.sh
```

使用之前创建的非 root 用户就可以登入了～

### 测试内容

使用人工测试的方式，共计 38 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|38|38|0|

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Gnome)

## Kiran

### 软件说明

kiran桌面是湖南麒麟信安团队以用户和市场需求为导向，研发的一个安全、稳定、高效、易用的桌面环境。kiran可以支持x86和aarch64架构。

正向设计桌面环境，自研包括登录锁屏界面、开始菜单、应用切换、任务栏工作区预览、系统托盘和控制中心等组件，在保证界面风格友好性的情况下更加节省资源；自研深浅色主题，界面功能清晰，呈现模块化的设计风格，通过层次化的方式优化功能布局，交互体验更加友好。

### 测试信息

#### 测试对象版本

|软件包名称|软件包版本|
|-|-|
| kiran-desktop | 2.2 |

#### 测试环境信息

### 安装方法

```bash
sudo dnf update
sudo dnf install kiran-desktop
systemctl set-default graphical.target
reboot
```

### 测试内容

使用人工测试的方式，共计 58 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|58|58|0|

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Kiran)

## Cinnamon

### 软件说明

Cinnamon 是运行在类 Unix 操作系统中最常用的桌面环境，也是一个功能完善、操作简单、界面友好、集使用和开发为一身的桌面环境，还是 GNU 计划的正式桌面。最初是 GNOME Shell 的一个派生版本，由 Linux Mint 开发，提供了相似于 Gnome 2，易于使用的传统用户界面，从 Cinnamon 2.0 开始，成为独立的桌面环境。

官方网站：https://projects.linuxmint.com/cinnamon/

### 环境配置

|操作系统版本|Qemu 版本|vcpu|memory|镜像|
|-|-|-|-|-|
| openEuler 23.03 riscv64 | | 8 | 8G | https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20230322/v0.1/QEMU/openEuler-23.02-V1-base-qemu-testing.qcow2.zst|

### 安装方法

1. 配置源并更新系统 下载 openEuler ISO镜像并安装系统，更新软件源

```bash
sudo dnf update
```

2. 安装字库

```bash
sudo dnf install dejavu-fonts liberation-fonts gnu-*-fonts google-*-fonts
```

3. 安装必要的 xorg 相关包。

```bash
sudo dnf install xorg-x11-apps xorg-x11-drivers xorg-x11-drv-ati \
	xorg-x11-drv-dummy xorg-x11-drv-evdev xorg-x11-drv-fbdev xorg-x11-drv-intel \
	xorg-x11-drv-libinput xorg-x11-drv-nouveau xorg-x11-drv-qxl \
	xorg-x11-drv-synaptics-legacy xorg-x11-drv-v4l xorg-x11-drv-vesa \
	xorg-x11-drv-vmware xorg-x11-drv-wacom xorg-x11-fonts xorg-x11-fonts-others \
	xorg-x11-font-utils xorg-x11-server xorg-x11-server-utils xorg-x11-server-Xephyr \
	xorg-x11-server-Xspice xorg-x11-util-macros xorg-x11-utils xorg-x11-xauth \
	xorg-x11-xbitmaps xorg-x11-xinit xorg-x11-xkb-utils
```

这里需要注意的是，在 openEuler 官方安装文档中，有 xorg-x11-drv-intel xorg-x11-drv-vesa xorg-x11-drv-vmware 这三个包，不过我们这里不需要。

4. 安装 Cinnamon 及组件

```bash
sudo dnf install cinnamon cinnamon-control-center cinnamon-desktop \
	cinnamon-menus cinnamon-screensaver cinnamon-session \
	cinnamon-settings-daemon  cinnamon-themes cjs \
	nemo nemo-extensions  muffin cinnamon-translations inxi \
	perl-XML-Dumper xapps mint-x-icons mint-y-icons mintlocale \
	python3-plum-py caribou mozjs78 python3-pam \
	python3-tinycss2 python3-xapp tint2 gnome-terminal \
	lightdm lightdm-gtk
```

5. 开机自动启动登录管理器

```bash
sudo systemctl enable lightdm
```


6. 设置系统默认以图形界面登录

```bash
sudo systemctl set-default graphical.target
```


7. 针对 QEMU 平台可能出现的无法启动/内核错误，请向启动脚本的 `cmd` 中添加如下内容。注意，需要 QEMU >= 8.0.0。

```bash
-cpu rv64,sv39=on \
```

### 参考资料

https://projects.linuxmint.com/cinnamon/

https://docs.openeuler.org/zh/docs/22.09/docs/desktop/Install_Cinnamon.html

### 测试内容

使用人工测试的方式，共计 35 个测试样例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|35|||

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test/Cinnamon)

## 新增备份还原功能支持

暂无

# 桌面应用

## 需求清单

| 名称        | 说明 | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues | 特性质量评估** | SIG 组 | 负责人 |
| ----------- | ---- | -------- | -------- | ------ | -------- | --------------- | ------ | -------------- | ------ | ------ |
| Firefox     |      |          |          |        |          | Y               |        | ▲              |        |        |
| Chromium    |      |          |          |        |          | Y               |        | ▲              |        |        |
| Thunderbird |      |          |          |        |          |                 |        | ●              |        |        |
| LibreOffice |      |          |          |        |          | Y               |        | ▲              |        |        |
| VLC         |      |          |          |        |          |                 |        | ●              |        |        |
| GIMP        |      |          |          |        |          | Y               |        | ▲              |        |        |

## Firefox

### 软件说明

Firefox 是一个免费和开源的浏览器，全世界10%的人使用Firefox作为他们的主要浏览器。Mozilla是Firefox 浏览器的开发商，主要提供专注于开放网络的产品。Firefox是谷歌Chrome浏览器的替代品。

### 测试信息

#### 测试对象版本

- Firefox 108.0.1-2.oe2203

#### 测试环境信息

- openEuler 22.03 RISC-V V2

### 参考资料

- [官网](https://www.firefox.com.cn/)
- [Firefox帮助](https://support.mozilla.org/zh-CN/products/firefox)

### 测试内容

使用人工测试的方式，测试了火狐安装、网页浏览、网页查找、网页通知、多媒体播放、文件下载、书签设置、历史记录等共计 75 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|75|71|4|

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Firefox)

## Chromium

### 测试信息

#### 测试对象版本

| Package | Arch | Version | Repo | Total_Size |
| ------- | ---- | ------- | ---- | ---------- |
| chromium | riscv64 | 103.0.5060.114 | mainline | 529 M |

#### 测试环境信息

| 硬件型号  | Qemu 版本  | vcpu | memory | 磁盘     |
| --------- | ---------- | ---- | ------ | -------- |
| RISC-V 64 | QEMU 7.2.0 | 8    | 8G     | 7.5G-15G |

### 测试内容

使用 openEuler 22.03 RISC-V V2 版本镜像，测试 Chromium 的安装和基本功能运行是否正常。

使用人工测试的方法，共计 166 个测试样例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|166|142|24|

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test/Chromium/)

## Thunderbird

### 测试信息

#### 测试对象版本

| Package | Arch | Version | Repo | Total_Size |
| ------- | ---- | ------- | ---- | ---------- |
| Thunderbird | riscv64 | 97.0 | mainline | 247 M |

#### 测试环境信息

| 硬件型号  | Qemu 版本  | vcpu | memory | 磁盘     |
| --------- | ---------- | ---- | ------ | -------- |
| RISC-V 64 | QEMU 7.2.0 | 8    | 8G     | 7.5G-15G |

### 测试内容

使用 openEuler 22.03 RISC-V V2 版本镜像，测试 Thunderbird 的安装和基本功能运行是否正常。

使用人工测试的方法，共计 22 个测试样例。

### 测试结果

openEuler 23.03 RISC-V 中构建为失败状态，软件源中缺少此软件包。

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/raw/master/System_and_Feature_Test/Thunderbird)

## LibreOffice

### 软件说明

LibreOffice（发音：/ˌliː.brəˈɒ.fɪs/）是由文档基金会开发的自由及开放源代码的办公室套件。LibreOffice套件包含文字处理器、电子表格、演示文稿程序、矢量图形编辑器和图表工具、数据库管理程序及创建和编辑数学公式的应用程序。

### 环境配置

#### 测试对象版本

- 软件版本： libreOffice 7.3.5.2 30(build:2)

#### 测试环境信息

- 操作系统版本： openEuler 22.03 LTS riscv64

### 参考资料

- [官网](https://www.libreoffice.org/)
- [LibreOffice 帮助](https://help.libreoffice.org/7.3/zh-CN/text/swriter/main0000.html)

### 测试内容

使用 openEuler 22.03 RISC-V V2 版本镜像，测试 Base 、 Calc 、 Draw 、 Impress 、 Math 、 Writer 的安装和基本功能运行是否正常。

使用人工测试的方法，共计 260 个测试样例。

### 测试结果

| 项目 | 测试用例总数 | 通过数 | 失败数 |
|-|-|-|-|
| LiberOffice | 5 | 5 | 0 |
| Base | 34 | 34 | 0 |
| Calc | 59 | 54 | 5 |
| Draw | 56 | 55 | 1 |
| Impress | 38 | 32 | 6 |
| Math | 13 | 12 | 1 |
| Writer | 55 | 48 | 7 |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/LibreOffice)

## VLC

### 软件说明

简单、快速、强大的媒体播放器。

VLC Media Player 是一款可播放大多数格式，而无需安装编解码器包的媒体播放器。

### 环境配置

#### 测试对象版本

- 软件版本： vlc riscv64 3.0.17.4-1.oe2203

#### 测试环境信息

- 操作系统版本： openEuler 22.09 LTS riscv64

### 参考资料

- [官网](https://www.videolan.org/vlc/)
- [VLC 帮助](https://docs.videolan.me/vlc-user/3.0/en/index.html)

### 测试结果

软件源中缺少此软件包

## GIMP

### 测试目的

使用 openEuler 22.03 RISC-V V2 版本镜像，测试 Chromium 的安装和基本功能运行是否正常。

### 测试信息

#### 测试对象版本

| Package | Arch | Version | Repo | Total_Size |
| ------- | ---- | ------- | ---- | ---------- |
| GIMP | riscv64 | 2.99.6 | mainline | 90 M |

#### 测试环境信息

| 硬件型号  | Qemu 版本  | vcpu | memory | 磁盘     |
| --------- | ---------- | ---- | ------ | -------- |
| RISC-V 64 | QEMU 7.2.0 | 8    | 8G     | 7.5G-15G |

### 测试内容

使用手动测试的方式，测试 Gimp 安装卸载以及其基础功能，共计 32 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
| 32 | 28 | 5 |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/GIMP)

# 容器

## 需求清单

| 名称                                      | 说明                                                                                                                                                                                                                                             | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                                                                                                                                                                                                                                                                 | 特性质量评估** | SIG 组          | 负责人 |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- | -------- | ------ | -------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- | --------------- | ------ |
| 容器(isula/docker/安全容器/系统容器/镜像) | 见 [I6QQLB](https://gitee.com/openeuler/iSulad/issues/I6QQLB) 有 iSulad sig 官方的黑盒测试工具；iSulad新增native network 特性                                                                                                                    | Y        | Y        | Y      | Y        | P               | [I6R1UT](https://gitee.com/openeuler/RISC-V/issues/I6R1UT) [I6R9OQ](https://gitee.com/openeuler/RISC-V/issues/I6R9OQ) [I6RDWA](https://gitee.com/openeuler/RISC-V/issues/I6RDWA) [I6RSAC](https://gitee.com/openeuler/RISC-V/issues/I6RSAC) [I6R5DH](https://gitee.com/openeuler/RISC-V/issues/I6R5DH) | ▲              | iSulad          |        |
| HA/高可用                                 | 仅安装成功                                                                                                                                                                                                                                       | Y        | Y        | N      | Y        | Y               |                                                                                                                                                                                                                                                                                                        |                | sig-Ha          |        |
| OpenStack Train & Wallaby                 |                                                                                                                                                                                                                                                  |          |          |        |          |                 |                                                                                                                                                                                                                                                                                                        |                | sig-openstack   |        |
| eggo                                      | 软件包存在，可安装，未测试                                                                                                                                                                                                                       | \*       | \*       | N      | N        | Y               |                                                                                                                                                                                                                                                                                                        |                | sig-CloudNative |        |
| NestOS                                    | 不支持 RISC-V                                                                                                                                                                                                                                    |          |          |        |          |                 |                                                                                                                                                                                                                                                                                                        |                | sig-CloudNative |        |
| 虚拟化 Virt                               | 优先级低，目前市面上尚无支持虚拟化的 RISC-V 硬件；openEuler 目前暂未实现，有虚拟化测试框架 avicado-vt，当前状态：[avocado-vt test on openEuler-riscv](https://gitee.com/lvxiaoqian/memo/blob/master/avocado-vt%20test%20on%20openEuler-riscv.md) | Y        | \*       | N      | N        | Y               |                                                                                                                                                                                                                                                                                                        |                | sig-Virt        |        |

## Docker

### 软件说明

Docker 是一个开源的 Linux 容器引擎项目， 用以实现应用的快速打包、部署和交付。Docker 的英文本意是码头工人，码头工人的工作就是将商品打包到 container （集装箱）并且搬运 container、装载 container。 对应到 Linux 中，Docker 就是将 APP 打包到 container，通过 container 实现 APP 在各种平台上的部署、运行。Docker 通过 Linux Container 技术将 APP 变成一个标准化的、可移植的、自管理的组件，从而实现应用的“一次构建，到处运行”。Docker 技术特点就是：应用快速发布、部署简单、管理方便，应用密度更高。

### 测试信息

#### 测试对象版本

- 软件版本：docker-engine-2:18.09.0-320.oe2303.riscv64

#### 测试环境信息

- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-3.oe2303.riscv64

### 参考资料

- [Docker 官方文档](https://docs.docker.com/)
- [openEuler 官方文档/容器用户指南](https://docs.openeuler.org/zh/docs/22.09/docs/Container/container.html)
- [RISC-V openEuler包移植从零开始](https://gitee.com/yunxiangluo/riscv-openeuler/) 

### 测试内容

使用人工测试的方式，测试 Docker 的安装卸载和基本功能，共计 31 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
| 31 | 31 | 0 |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Containers/Docker)

## iSulad

### 软件说明

iSulad是一个由C/C++编写实现的轻量级容器引擎，具有轻、灵、巧、快的特点，不受硬件规格和架构限制，底噪开销更小，可应用的领域更为广泛。

### 测试信息

#### 测试对象版本

- 软件版本：iSulad-2.1.1-7.oe2303.riscv64

#### 测试环境信息

环境 1:
- 硬件信息：QEMU 7.2.0，8*vCPU，8GB RAM
- 操作系统版本：openEuler 23.03 riscv64, Linux 6.1.8-3.oe2303.riscv64

环境 2:
- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-7.oe2303.riscv64

除非另有说明，测试默认在 StarFive VisionFive 2 平台进行。

### 参考资料

- [openEuler 官方文档/容器用户指南](https://docs.openeuler.org/zh/docs/22.09/docs/Container/container.html)

### 测试内容

使用人工测试的方式，测试 iSulad 的安装卸载和基本功能，共计 25 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
| 25 | 25 | 0 |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Containers/iSulad)

## 安全容器

### 软件说明

安全容器依赖于 `docker-engine`、`qemu` 以及 `kata-containers`，需要进行安装。

### 安装方法

1. 运行：`sudo dnf install -y docker-engine`
2. 运行：`sudo dnf install -y qemu`
3. 运行：`sudo dnf install -y kata-containers`。

### 测试内容

使用人工测试的方式，测试安全容器功能是否能够正常安装和卸载。

### 测试结果

`docker-engine` 和 `qemu` 安装成功，`kata-containers` 软件包缺失，安装失败。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Containers/%E5%AE%89%E5%85%A8%E5%AE%B9%E5%99%A8)

## 容器镜像构建

### 软件说明

`isula-build` 是 iSula 容器团队推出的容器镜像构建工具，支持通过`Dockerfile` 文件快速构建容器镜像。

`isula-build` 采用服务端/客户端模式，其中，`isula-build` 为客户端，提供了一组命令行工具，用于镜像构建及管理等；`isula-builder` 为服务端，用于处理客户端管理请求，作为守护进程常驻后台。

### 测试信息

#### 测试对象版本

- 软件版本：isula-build-0.9.6-19.oe2303.riscv64

#### 测试环境信息

环境 1:
- 硬件信息：QEMU 7.2.0，8*vCPU，8GB RAM
- 操作系统版本：openEuler 23.03 riscv64, Linux 6.1.8-3.oe2303.riscv64

环境 2:
- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-7.oe2303.riscv64

除非另有说明，测试默认在 StarFive VisionFive 2 平台进行。

### 测试内容

测试采用人工测试的方式进行，测试了容器镜像的安装卸载和基本功能，共计 13 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
| 13 | 13 | 0 |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Containers/%E5%AE%B9%E5%99%A8%E9%95%9C%E5%83%8F%E6%9E%84%E5%BB%BA)

## 系统容器

### 安装方法

1. 安装 iSulad 容器引擎：`sudo dnf install -y iSulad`
2. 安装系统容器依赖包：`sudo dnf install -y syscontainer-tools authz lxcfs-tools lxcfs`
3. 检查 iSulad 是否启动：`sudo systemctl status isulad`
4. 启动 `lxcfs` 和 `authz` 服务：`sudo systemctl start lxcfs authz`
5. 检查 `lxcfs` 服务是否启动成功：`sudo systemctl status lxcfs`
6. 检查 `authz` 服务是否启动成功：`sudo systemctl status authz`

### 测试内容

安装系统容器所依赖的软件包。

### 测试结果

iSulad 容器引擎及依赖包安装成功，并且成功启动 `lxcfs` 和 `authz` 服务。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/Containers/%E7%B3%BB%E7%BB%9F%E5%AE%B9%E5%99%A8)

## HA/高可用

### 安装方法

```
dnf install openresty
```

### 使用方法

> 需要至少两台安装了openEuler 23.03 的物理机/虚拟机（现以两台为例）
> 两台主机均需要进行以下操作，现以其中一台为例，下文中使用的IP仅供参考。

#### 1. 修改主机名

```console
# hostnamectl set-hostname ha1
```
#### 2. 编辑 `/etc/hosts`

```text
172.16.16.16 ha1
172.16.16.17 ha2
```

#### 3. 安装 HA 软件包组件

```console
# dnf install -y corosync pacemaker pcs fence-agents fence-virt corosync-qdevice sbd drbd drbd-utils
```

#### 4. 设置 `hacluster` 用户密码

```console
# passwd hacluster
```

#### 5. 编辑 `/etc/corosync/corosync.conf`

```
totem {
        version: 2
        cluster_name: hacluster
         crypto_cipher: none
        crypto_hash: none
}
logging {         
        fileline: off
        to_stderr: yes
        to_logfile: yes
        logfile: /var/log/cluster/corosync.log
        to_syslog: yes
        debug: on
       logger_subsys {
               subsys: QUORUM
               debug: on
        }
}
quorum {
           provider: corosync_votequorum
           expected_votes: 2
           two_node: 1
       }
nodelist {
       node {
               name: ha1
               nodeid: 1
               ring0_addr: 172.16.16.16
               }
        node {
               name: ha2
               nodeid: 2
               ring0_addr: 172.16.16.17
               }
        }
```

#### 6. 启动服务

```bash
# 启动 pcs 服务
systemctl start pcsd

# 启动 pacemaker 服务
systemctl start pacemaker

# 启动 corosync 服务
systemctl start corosync
```

#### 7. 节点鉴权
> 任选一个节点上执行即可

```console
# pcs host auth ha1 ha2
```

#### 8. 访问前端管理平台

上述服务启动后，可以在 `http://localhost:2224` 看到前端管理页面。

### 参考文档

https://docs.openeuler.org/zh/docs/23.03/docs/thirdparty_migration/installha.html

### 测试结果

暂无测试结果

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/HA)

# k8s 相关

## 需求清单

| 名称       | 说明                                                                              | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                     | 特性质量评估** | SIG 组          | 负责人 |
| ---------- | --------------------------------------------------------------------------------- | -------- | -------- | ------ | -------- | --------------- | ---------------------------------------------------------- | -------------- | --------------- | ------ |
| kubernetes |                                                                                   | Y        | \*       | Y      | Y        | Y               |                                                            |                | sig-CloudNative |        |
| kubeOS     |                                                                                   | \*       | \*       | N      | N        | Y               |                                                            |                | sig-CloudNative |        |
| KubeSphere | [安装文档](https://docs.openeuler.org/zh/docs/23.03/docs/desktop/kubesphere.html) |          |          |        |          |                 |                                                            |                | sig-CloudNative |        |
| k3s        | 23.03 需要回归测试                                                                | Y        | \*       | N      | N        | Y               | [I6RRJT](https://gitee.com/openeuler/RISC-V/issues/I6RRJT) |                | sig-K8sDistro   |        |

## kubernetes

### 软件说明

Kubernetes（也称 k8s 或 “kube”）是一个[开源](https://www.redhat.com/zh/topics/open-source/what-is-open-source)的容器编排平台，可以自动完成在部署、管理和扩展容器化应用过程中涉及的许多手动操作。

Kubernetes 最初由 Google 的工程师开发和设计。Google 是最早研发 Linux 容器技术的企业之一，曾公开分享 [Google 如何将一切都运行于容器之中](https://speakerdeck.com/jbeda/containers-at-scale)。（这是在 Google [云服务](https://www.redhat.com/zh/topics/cloud-computing/what-are-cloud-services)背后的技术。）

Google 每周产生超过 20 亿个容器部署，全都由内部平台 [Borg](http://blog.kubernetes.io/2015/04/borg-predecessor-to-kubernetes.html) 支撑。Borg 是 Kubernetes 的前身，多年来开发 Borg 的经验教训成了影响 Kubernetes 中许多技术的主要因素。

### 测试信息

#### 测试对象版本

- 软件版本：

```
Name         : kubernetes
Version      : 1.20.2
Release      : 8.oe2303
Architecture : riscv64
Size         : 0.0
Source       : kubernetes-1.20.2-8.oe2303.src.rpm
Repository   : @System
From repo    : epol
Summary      : Container cluster management
URL          : https://k8s.io/kubernetes
License      : ASL 2.0
Description  : Container cluster management.
```

#### 测试环境信息

- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-7.oe2303.riscv64

### 安装方法

```bash
sudo dnf install -y kubernetes*
```

### 测试内容

使用人工测试的方式测试其是否能够正常安装和卸载。

使用 mugen 进行功能上的测试。

### 测试结果

``kubernetes`` 及其依赖安装成功。

mugen 拥有其测试用例，但是两个用例有问题。

上游使用 E2E 测试，即 kubetest，该工具已被 Kubernetes 上游 Deprecated，目前在 Go 1.19 下无法执行。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/kubernetes)

#### 相关issue

向mugen上游提出的:

- [#I6RFZV kubernetes测试套中oe_test_service_kube-apiserver和 oe_test_service_kube-proxy两个用例执行失败](https://gitee.com/openeuler/mugen/issues/I6RFZV)

提问相关的:

- [#I6QIGJ 请问openEuler这边对kubernetes使用什么样的方法进行测试](https://gitee.com/openeuler/cloudnative/issues/I6QIGJ)

## kubeOS

### 软件说明

KubeOS 是针对业务以容器的形式运行的场景，专门设计的一种轻量级操作系统。KubeOS 通过 kubernetes CRD + operator 扩展机制将将 OS 作为组件接入 kubernetes，使 OS 和业务处于同等地位，用户通过 kubernetes 集群统一管理节点上的容器和节点 OS，实现一套系统管理容器和 OS。

### 测试信息

#### 测试对象版本

- 软件版本：KubeOS-1.0.2-9.oe2303.riscv64

#### 测试环境信息

- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-7.oe2303.riscv64

### 安装方法

```bash
sudo dnf install -y KubeOS*
```

### 参考资料

[openEuler Docs 22.09 - 容器 OS 升级用户指南](https://docs.openeuler.org/zh/docs/22.03_LTS_SP1/docs/KubeOS/overview.html)

### 测试内容

使用人工测试的方式，安装 KubeOS 及其依赖包

### 测试结果

``KubeOS`` 及其依赖安装成功。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/kubeOS)

## KubeSphere

### 软件说明

KubeSphere 是在 Kubernetes 之上构建的面向云原生应用的**分布式操作系统**，完全开源，支持多云与多集群管理，提供全栈的 IT 自动化运维能力，简化企业的 DevOps 工作流。它的架构可以非常方便地使第三方应用与云原生生态组件进行即插即用（plug-and-play）的集成。

### 安装方法

1.安装KubeKey

``` bash
yum install kubekey
```

2.部署 KubeSphere 集群

```bash
kk create cluster --with-kubesphere v3.1.1
```

3.验证 KubeSphere 集群是否安装成功

```bash
kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f
```

### 参考资料

[openEuler Docs 23.03 - KubeSphere 部署指南]https://docs.openeuler.org/zh/docs/23.03/docs/desktop/kubesphere.html

### 测试结果

目前KubeKey包存在错误，无法部署 KubeSphere 集群

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/kubesphere)

## OpenStack Train & Wallaby

暂无

## eggo

暂无

## NestOS

### 测试内容

测试 NestOS 能否在 openEuler 23.03 V1 Risc-V 上正常运行。

### 测试结果

根据 openEuler [官方文档](https://docs.openeuler.org/zh/docs/23.03/docs/NestOS/安装与部署.html)的描述：目前 NestOS 已支持 x86_64 和 aarch64 架构。尚未支持 Risc-V。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/NestOS)

## 虚拟化 Virt

### 软件说明

在计算机技术中，虚拟化是一种资源管理技术，它将计算机的各种实体资源（处理器、内存、磁盘、网络适配器等）予以抽象、转换后呈现，并可分割、组合为一个或多个计算机配置环境。这种资源管理技术打破了实体结构不可分割的障碍，使这些资源在虚拟化后不受现有资源的架设方式、地域或物理配置限制，从而让用户可以更好地应用计算机硬件资源，提高资源利用率。

虚拟化使得一台物理服务器上可以运行多台虚拟机，虚拟机共享物理机的处理器、内存、I/O设备等资源，但逻辑上虚拟机之间是互相隔离的。在虚拟化技术中，通常将这个物理服务器称为宿主机，宿主机上运行的虚拟机也叫客户机，虚拟机内部运行的操作系统称为客户机操作系统。在宿主机和虚拟机之间存在一层叫虚拟化层的软件，用于实现虚拟硬件的模拟，通常这个虚拟化层被称为虚拟机监视器，如下图所示：

**图 1** 虚拟化架构
![img](https://docs.openeuler.org/zh/docs/22.03_LTS/docs/Virtualization/figures/virtualized-architecture.png)

openEuler软件包中提供的虚拟化相关组件：

- KVM：提供核心的虚拟化基础设施，使Linux系统成为一个hypervisor，支持多个虚拟机同时在该主机上运行。
- QEMU：模拟处理器并提供一组设备模型，配合KVM实现基于硬件的虚拟化模拟加速。
- Libvirt：为管理虚拟机提供工具集，主要包含统一、稳定、开放的应用程序接口（API）、守护进程 （Libvirtd）和一个默认命令行管理工具（virsh）。
- Open vSwitch：为虚拟机提供虚拟网络的工具集，支持编程扩展，以及标准的管理接口和协议（如NetFlow， sFlow，IPFIX， RSPAN， CLI， LACP， 802.1ag）。


### 安装方法

#### 前提条件

1. yum.repo里要有这项([https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.03-V1-riscv64/repo/extra/ceph-user/](https://gitee.com/link?target=https%3A%2F%2Fmirror.iscas.ac.cn%2Fopeneuler-sig-riscv%2FopenEuler-RISC-V%2Fpreview%2FopenEuler-23.03-V1-riscv64%2Frepo%2Fextra%2Fceph-user%2F))
2. 安装操作需要root用户权限。

#### 安装步骤

1. 安装QEMU组件。

   ```shell
   yum install -y qemu
   ```

2. 安装libvirt组件。

   ```shell
   yum install -y libvirt
   ```

3. 启动libvirtd服务。

   ```shell
   systemctl start libvirtd
   ```

**说明：**KVM模块已经集成在openEuler内核中，因此不需要单独安装。

#### 验证安装是否成功

1. 查看内核是否支持 KVM 虚拟化，即查看 /dev/kvm 和 /sys/module/kvm 文件是否存在，命令和回显如下：

   ```shell
   [root@openeuler-riscv64 ~]# ls /dev/kvm
   /dev/kvm
   [root@openeuler-riscv64 ~]# ls /sys/module/kvm
   parameters  uevent
   ```

   若上述文件存在，说明内核支持 KVM 虚拟化。若上述文件不存在，则说明系统内核编译时未开启 KVM 虚拟化，需要更换支持 KVM 虚拟化的 Linux 内核。

2. 确认 QEMU 是否安装成功。若安装成功则可以看到 QEMU 软件包信息，命令和回显如下：

   ```shell
   [root@openeuler-riscv64 ~]# rpm -qi qemu
   Name        : qemu
   Epoch       : 10
   Version     : 6.2.0
   Release     : 68.oe2303
   Architecture: riscv64
   Install Date: Sun 02 Apr 2023 09:22:48 PM CST
   Group       : Unspecified
   Size        : 20923916
   License     : GPLv2 and BSD and MIT and CC-BY-SA-4.0
   Signature   : RSA/SHA1, Thu 30 Mar 2023 01:01:10 AM CST, Key ID e8824b862466a8cc
   Source RPM  : qemu-6.2.0-68.oe2303.src.rpm
   Build Date  : Wed 29 Mar 2023 08:47:19 PM CST
   Build Host  : oerv-obs-worker-01
   Packager    : http://openeuler.org
   Vendor      : http://openeuler.org
   URL         : http://www.qemu.org
   Summary     : QEMU is a generic and open source machine emulator and virtualizer
   Description :
   QEMU is a FAST! processor emulator using dynamic translation to achieve good emulation speed.
   
   QEMU has two operating modes:
   
      Full system emulation. In this mode, QEMU emulates a full system (for example a PC),
      including one or several processors and various peripherals. It can be used to launch
      different Operating Systems without rebooting the PC or to debug system code.
   
      User mode emulation. In this mode, QEMU can launch processes compiled for one CPU on another CPU.
      It can be used to launch the Wine Windows API emulator (https://www.winehq.org) or to ease
      cross-compilation and cross-debugging.
   You can refer to https://www.qemu.org for more infortmation.
   ```

3. 确认libvirt是否安装成功。若安装成功则可以看到libvirt软件包信息，命令和回显如下：

   ```shell
   [root@openeuler-riscv64 ~]# rpm -qi libvirt
   Name        : libvirt
   Version     : 6.2.0
   Release     : 52.oe2303
   Architecture: riscv64
   Install Date: Sun 02 Apr 2023 09:25:38 PM CST
   Group       : Unspecified
   Size        : 0
   License     : LGPLv2+
   Signature   : RSA/SHA1, Mon 20 Mar 2023 09:08:24 AM CST, Key ID e8824b862466a8cc
   Source RPM  : libvirt-6.2.0-52.oe2303.src.rpm
   Build Date  : Mon 20 Mar 2023 06:05:13 AM CST
   Build Host  : oerv-obs-worker-06
   Packager    : http://openeuler.org
   Vendor      : http://openeuler.org
   URL         : https://libvirt.org/
   Summary     : Library providing a simple virtualization API
   Description :
   Libvirt is a C toolkit to interact with the virtualization capabilities
   of recent versions of Linux (and other OSes). The main package includes
   the libvirtd server exporting the virtualization support.
   ```

4. 查看libvirt服务是否启动成功。若服务处于“Active”状态，说明服务启动成功，可以正常使用libvirt提供的virsh命令行工具，命令和回显如下：

   ```shell
   [root@openeuler-riscv64 ~]# systemctl status libvirtd
   ● libvirtd.service - Virtualization daemon
        Loaded: loaded (/usr/lib/systemd/system/libvirtd.service; enabled; vendor >
        Active: active (running) since Mon 2023-04-03 14:20:10 CST; 1s ago
   TriggeredBy: ● libvirtd.socket
                ● libvirtd-ro.socket
                ● libvirtd-admin.socket
          Docs: man:libvirtd(8)
                https://libvirt.org
      Main PID: 732 (libvirtd)
         Tasks: 17 (limit: 32768)
        Memory: 16.0M
        CGroup: /system.slice/libvirtd.service
                └─ 732 /usr/sbin/libvirtd --timeout 120
   ```


### 参考资料

https://docs.openeuler.org/zh/docs/22.03_LTS_SP1/docs/Virtualization/%E5%AE%89%E8%A3%85%E8%99%9A%E6%8B%9F%E5%8C%96.html

### 测试内容

使用人工测试的方式，验证虚拟化 Virt 功能能否正常安装和运行。

### 测试结果

虚拟化 Virt 功能正常安装和运行。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test/Virt)

## k3s

### 软件说明

K3s 是一个轻量级的 Kubernetes 发行版，它针对边缘计算、物联网等场景进行了高度优化。K3s 有以下增强功能：

- 打包为单个二进制文件。
- 使用基于 sqlite3 的轻量级存储后端作为默认存储机制。同时支持使用 etcd3、MySQL 和 PostgreSQL 作为存储机制。
- 封装在简单的启动程序中，通过该启动程序处理复杂的 TLS 和选项。
- 默认情况下是安全的，对轻量级环境有合理的默认值。
- 添加了简单但功能强大的batteries-included功能，例如：本地存储提供程序，服务负载均衡器，Helm controller 和 Traefik Ingress controller。
- 所有 Kubernetes control-plane 组件的操作都封装在单个二进制文件和进程中，使 K3s 具有自动化和管理包括证书分发在内的复杂集群操作的能力。
- 最大程度减轻了外部依赖性，K3s 仅需要 kernel 和 cgroup 挂载。

K3s 适用于以下场景：

- 边缘计算-Edge
- 物联网-IoT
- CI
- Development
- ARM
- 嵌入 K8s

由于运行 K3s 所需的资源相对较少，所以 K3s 也适用于开发和测试场景。在这些场景中，如果开发或测试人员需要对某些功能进行验证，或对某些问题进行重现，那么使用 K3s 不仅能够缩短启动集群的时间，还能够减少集群需要消耗的资源。

### 测试信息

#### 测试对象版本

```
Name         : k3s
Version      : 1.24.2+rc1+k3s2
Release      : 3.oe2303
Architecture : riscv64
Size         : 68 M
Source       : k3s-1.24.2+rc1+k3s2-3.oe2303.src.rpm
Repository   : @System
From repo    : epol
Summary      : Installer for k3s optimised for openSUSE MicroOS
URL          : https://k3s.io
License      : Apache-2.0
Description  : Based on the official upstream k3s install.sh, this k3s-install
             : package provides a curated, MicroOS-optimised, securely delivered
             : alternative to running a script directly from the internet.
             :
             : k3s is a container orchestration system for automating application
             : deployment, scaling, and management. It is a Kubernetes-compliant
             : distribution that differs from the original Kubernetes (colloquially
             : "k8s") in that:
             :
             :   * Legacy, alpha, or non-default features are removed.
             :   * Most in-tree plugins (cloud providers and storage plugins) were
             :     removed, since they can be replaced with out-of-tree addons.
             :   * sqlite3 is the default storage mechanism.
             :     etcd3 is still available, but not the default.
             :   * There is a new launcher that handles a lot of the complexity of
             :     TLS and options.
```

### 安装方法

```
sudo dnf install k3s
```

### 测试方法

使用人工测试的方式，验证 k3s 功能是否能正常安装。

还未调研出官方是否有测试框架， mugen 没有其测试用例

### 参考资料

[openEuler Docs - 22.09 K3s 部署指南](https://docs.openeuler.org/zh/docs/22.09/docs/K3s/K3s%E9%83%A8%E7%BD%B2%E6%8C%87%E5%8D%97.html)

[K3s 官方文档](https://rancher.com/docs/k3s/latest/en/)

[K3s 中文文档](https://docs.rancher.cn/k3s/)

### 测试结果

安装出现问题。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/k3s)

#### 相关issue

- [#I6RRJT 23.02k3s安装过程中出现的一些关于AST的报错](https://gitee.com/openeuler/RISC-V/issues/I6RRJT)

# 内存管理

## 需求清单

| 名称  | 说明     | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                     | 特性质量评估** | SIG 组  | 负责人 |
| ----- | -------- | -------- | -------- | ------ | -------- | --------------- | ---------------------------------------------------------- | -------------- | ------- | ------ |
| etmem | 启动失败 | \*       | \*       | N      | N        | Y               | [I6V7C0](https://gitee.com/openeuler/RISC-V/issues/I6V7C0) | ×              | Storage |        |

## etmem

### 测试结果

启动失败

# 内核

## 需求清单

| 名称            | 说明                                                  | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                     | 特性质量评估** | SIG 组            | 负责人 |
| --------------- | ----------------------------------------------------- | -------- | -------- | ------ | -------- | --------------- | ---------------------------------------------------------- | -------------- | ----------------- | ------ |
| kernel          | 使用开源测试套LTP/mmtest<br>LTP已纳入基础测试且已完成 | Y        | Y        | Y      | Y        | N/A             |                                                            | ▲              | sig-kernel/sig-QA |        |
| kconfigDetector | OBS 已有且构建成功，暂未进源                          | Y        | Y        | Y      | Y        | Y               | [I6V7CP](https://gitee.com/openeuler/RISC-V/issues/I6V7CP) | █              |                   |        |

## kernel

### 软件说明

openEuler 23.03 将 Linux 内核的版本更新到了 6.1。

### 测试信息

#### 测试对象版本

- 内核版本：6.1.19-2.oe2303.riscv64

#### 测试环境信息

- OS 版本：openEuler 23.03 RISC-V V1
- 内核版本：6.1.19-2.oe2303.riscv64
- 虚拟机版本：QEMU 8.0.0-1
- 宿主机：Arch Linux on Windows 11 x86_64

### 测试内容

使用 Linux Test Project（简称 LTP）对内核进行测试。本次测试使用的 LTP 版本为 [20230127](https://github.com/linux-test-project/ltp/releases/tag/20230127)。

#### 增加内核配置

在 `/boot/config-6.1.19-2.oe2303.riscv64` 中添加以下内核配置：

```
###########################
#  from/for LTP-20230127  #
###########################
# Stream Control Transmission Protocol
CONFIG_IP_SCTP=m
# file systems
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
# ntfs config come from OLK 5.10 which backported NTFS3 from 5.15
CONFIG_NTFS_FS=m
CONFIG_NTFS3_FS=m
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_MINIX_FS=m
# quota
CONFIG_QUOTA=y
CONFIG_QFMT_V2=m
# LSM module
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"
CONFIG_IMA=y 
# accounting
CONFIG_BSD_PROCESS_ACCT=y
# 'encrypted' key
CONFIG_BIG_KEYS=y
CONFIG_ENCRYPTED_KEYS=m
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
# RAM block device
CONFIG_BLK_DEV_RAM=m
# TUN/TAP
CONFIG_TUN=m
CONFIG_MACVTAP=m
CONFIG_IPVTAP=m
# Kernel Samepage Merging
CONFIG_KSM=y
# Enable userfaultfd() system call
CONFIG_USERFAULTFD=y
# per-task storage I/O accounting
CONFIG_TASKSTATS=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# Reliable Datagram Sockets Protocol
CONFIG_RDS=m
CONFIG_RDS_TCP=m
# netfilter 'state' match
CONFIG_NETFILTER_XT_MATCH_STATE=m
# perf event
CONFIG_PERF_EVENTS=y
# FS integrity check
CONFIG_FS_VERITY=y
# miscellaneous binary
CONFIG_BINFMT_MISC=m
# optimize scheduler for common desktop
CONFIG_SCHED_AUTOGROUP=y
# CGroup controllers
CONFIG_CGROUP_DEBUG=y
CONFIG_BLK_CGROUP=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_CGROUP_PERF=y
# Process Event Connector
CONFIG_CONNECTOR=y
# Virtual Local CAN Interface
CONFIG_CAN=m
CONFIG_CAN_VCAN=m
# user level input driver
CONFIG_INPUT_MISC=y
CONFIG_INPUT_UINPUT=m
# SM3 SM4, OLK5.10 backported new config
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_SM4_GENERIC=m 
# sound sequencer
CONFIG_SND_SEQUENCER=m
# Virtual Socket protocol
CONFIG_VSOCKETS=m
# torture test
CONFIG_RCU_TORTURE_TEST=m
CONFIG_LOCK_TORTURE_TEST=m
# zram
CONFIG_ZSMALLOC=m
CONFIG_ZRAM=m
# watch queue
CONFIG_WATCH_QUEUE=y
CONFIG_KEY_NOTIFICATIONS=y
# PCIe Advanced Error Reporting register
CONFIG_PCIEAER=y

# for iproute-5.15.0
CONFIG_NET_IPGRE_DEMUX=m    # gre.ko
CONFIG_IPV6_GRE=m           # ip6_gre.ko
CONFIG_IPV6_TUNNEL=m        # ip6_tunnel.ko
CONFIG_NET_IPGRE=m          # ip_gre.ko
CONFIG_NET_IPIP=m           # ip_tunnel.ko
CONFIG_NET_CLS_ACT=y
CONFIG_NET_CLS_U32=m        # cls_u32.ko
CONFIG_NET_SCH_INGRESS=m    # qdisc
CONFIG_NET_SCH_DSMARK=m     # sch_dsmark.ko
CONFIG_NET_ACT_PEDIT=m      # act_pedit.ko

# for libnetfilter_conntrack-1.0.9
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m   # "connlabel"
CONFIG_NF_CONNTRACK_LABELS=y

# for conntrack-tools-1.4.7
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CONNTRACK_PPTP=m
```

#### 测试环境准备

- 安装编译工具

```shell-session
# dnf install gcc git make pkgconf autoconf automake bison flex m4 kernel-tools kernel-headers kernel-devel glibc-headers
```

- 安装测试所需的工具

```shell-session
# dnf install openssl-devel libacl-devel libaio-devel libcap-devel ethtool expect-devel xfsprogs-devel btrfs-progs quota nfs-util libmnl-devel libtirpc-devel
```

- 设置交换空间，这里设置了 8 GiB。

```shell-session
# dd if=/dev/zero of=/swapfile bs=1M count=8192 status=progress
# chmod 0600 /swapfile
# mkswap /swapfile
# swapon /swapfile
```

- 去除内存限制：删去 `/boot/extlinux/extlinux.conf` 中的 `mem=4096M`。

#### 准备两个测试用虚拟盘

在宿主机：

```shell-session
$ qemu-img create -f qcow2 ext2g.qcow2 2G
$ qemu-img create -f qcow2 ext1g.qcow2 1G
```

同时，在 QEMU 命令行中增加以下参数：

```shell-session
  -drive file=ext2g.qcow2,format=qcow2,id=hd1 \
  -drive file=ext1g.qcow2,format=qcow2,id=hd2 \
  -device virtio-blk-device,drive=hd1 \
  -device virtio-blk-device,drive=hd2 \
```

在虚拟机，将其各分为一个区，格式化为 ext4：

```shell-session
# fdisk /dev/vdb
# mkfs.ext4 /dev/vdb1
# fdisk /dev/vdc
# mkfs.ext4 /dev/vdc1
```

#### 下载、编译、安装 LTP

```shell-session
# wget https://github.com/linux-test-project/ltp/releases/download/20230127/ltp-full-20230127.tar.xz
# tar -xvf ltp-full-20230127.tar.xz
# cd ltp-full-20230127
# make autotools
# ./configure --with-bash --with-expect --with-perl --with-python
# make
# make install
```

#### 运行测试

测试的临时文件目录默认是 `/tmp`，但 openEuler 已将其安装为 tmpfs，这会导致很多测试意外失败。因此专门建立一个目录，并在运行脚本参数中指明。

```shell-session
# mkdir -p /ltp/tmp
```

为防止测试超时错误，增大超时限制的倍数。

```shell-session
# export LTP_TIMEOUT_MUL=10
```

运行：

```shell-session
# cd /opt/ltp
# ./runltp -p -o tests.output -d /ltp/tmp -b /dev/vdc1 -B ext4 -z /dev/vdb1 -Z ext4
```

### 测试结果

- 测试用例总数：2379
- 跳过的：308
- 失败的：32

详细的测试结果见附件。

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test/Kernel_6.1)

#### 附件

附有此次 LTP 测试产生的 `output` 目录和 `results` 目录。

- `results/LTP_RUN_ON-2023_04_30-08h_15m_39s.log`：测试结果统计。
- `output/LTP_RUN_ON-tests.output.failed` 失败测试的名字（tag）及具体命令。
- `output/LTP_RUN_ON-tests.output.tconf`：（可能）需要调整配置的测试名（tag）及具体命令，包括且大部分为主动跳过的测试。
- `output/tests.output.gz`：所有测试的日志，因原文件过大，故使用 Gzip 压缩。
- `output/cpuctl_results_stress-*.txt`：从文件名上看，似乎为进行 CPU 相关测试时产生的输出，但是这几个文件都只有一行日期。

## kconfigDetector

### 软件说明

`kconfigDetector` 是为内核配置提供的一系列检测工具。包括：

* kconfigDepDetector 内核配置项错误值检测工具
  依据内核源码中各配置项的Kconfig定义，检测出内核配置文件中不满足依赖、取值等约束条件的错误值，并提供父类和子类配置项查询功能。  

### 测试信息

#### 测试对象版本

- 软件版本：kconfigDetector-v1.0.0-1.oe2303.riscv64

#### 测试环境信息

- 硬件信息：QEMU 7.2.1 on Arch Linux (on WSL 2)，8*vCPU + 8GB RAM
- 操作系统版本：openEuler 23.03 preview riscv64, Linux 6.1.19-2.oe2303.riscv64

### 安装方法

由于目前 openEuler RISC-V 23.03 软件源中暂无此软件包，但 OBS 已经成功构建完成，可手动下载 rpm 包，通过 dnf 安装。

```bash
wget http://obs-backend.tarsier-infra.com:82/openEuler:/23.03:/Epol/23.03/noarch/kconfigDetector-v1.0.0-1.oe2303.noarch.rpm
sudo dnf install -y kconfigDetector-v1.0.0-1.oe2303.noarch.rpm
```

### 参考资料

[openeuler/kconfigDetector](https://gitee.com/openeuler/kconfigDetector)

### 测试内容

使用人工测试的方式，测试 kconfigDetector 安装卸载和基本功能，共 2 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
|2|2|0|

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/kconfigDetector)

# Web 服务

## 需求清单

| 名称      | 说明 | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues | 特性质量评估** | SIG 组        | 负责人 |
| --------- | ---- | -------- | -------- | ------ | -------- | --------------- | ------ | -------------- | ------------- | ------ |
| OpenResty |      | Y        | Y        | N      | Y        | Y               |        |                | sig-OpenResty |        |

## OpenResty

### 软件说明

openResty 是一个基于 NGINX 的可伸缩的 Web 平台，由中国人章亦春发起，提供了很多高质量的第三方模块。

OpenResty 是一个强大的 Web 应用服务器，Web 开发人员可以使用 Lua 脚本语言调动 Nginx 支持的各种 C 以及 Lua 模块,更主要的是在性能方面，OpenResty可以 快速构造出足以胜任 10K 以上并发连接响应的超高性能 Web 应用系统。

### 安装方法

```
dnf install openresty
```

### 使用方法

```
mkdir /home/www
cd /home/www/
mkdir logs/ conf/

```

在 conf 目录下面创建一个 nginx.conf，内容如下：
``` conf
worker_processes  1;
error_log logs/error.log;
events {
    worker_connections 1024;
}
http {
    server {
        listen 9000;
        location / {
            default_type text/html;
            content_by_lua '
                ngx.say("<p>Hello, World!</p>")
            ';
        }
    }
}

```
运行
```
cd /home/www
/usr/local/openresty/nginx/sbin/nginx -p `pwd`/ -c conf/nginx.conf
```
如果没有输出则为成功

使用 curl 测试使用
```
curl http://localhost:9000/
```
输出结果：
```
<p>Hello, World!</p>
```

### 参考资料

http://openresty.org/

http://qa.openresty.org/

https://www.runoob.com/w3cnote/openresty-intro.html

### 测试结果

暂无测试结果

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/openResty)

# 数据库

## 需求清单

清单中不存在但是被测试过。

## Mysql

### 测试内容

使用人工测试的方法，测试了 Mysql 数据库的基本功能，共计 49 个测试用例。

### 测试结果

| 测试用例总数 | 通过数 | 失败数 |
|-|-|-|
| 49 | 48 | 1 |

[测试结果仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/MYSQL)

# 编译器

## 需求清单

| 名称             | 说明                                                                                                                                                                                                                                         | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues | 特性质量评估** | SIG 组   | 负责人 |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------- | ------ | -------- | --------------- | ------ | -------------- | -------- | ------ |
| 编译器 (gcc/jdk) | gcc 在基础测试中已完成，JDK 官方回归测试套件 jtreg 需要自行编译执行，上游和 oErv 源均不提供，目前已完成 OpenJDK 19; QEMU 下执行 JDK 11/17/19 需要指定 sv39 页表；GCC编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能 （未测试） | P        | \*       | P      | P        | P               |        | █              | Compiler |        |
| 毕昇 JDK         | 暂无                                                                                                                                                                                                                                         |          |          |        |          |                 |        |                |          |        |

## jdk

### 软件说明

JDK（Java Development Kit）是 Java 开发者进行 Java 开发所必须的软件包，包含 JRE（Java Runtime Environment）和编译、调测工具。此外，OpenJDK 也提供了 jtreg 作为回归测试框架，方便开发者进行测试代码的编写与执行。

### 测试内容

使用 OpenJDK 官方回归测试框架 jtreg 对 OpenJDK 19 进行测试。

### 环境配置

#### 测试对象版本

- 软件版本：java-latest-openjdk-19.0.2.7-1.rolling.oe2303

#### 测试环境信息

- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-7.oe2303.riscv64

### 运行步骤

1. 安装 OpenJDK 19。

```bash
sudo dnf install java-latest-openjdk-devel
```

2. 如系统上存在其他版本的 JDK，请先切换到 JDK 19。

```bash
sudo alternatives --config java
```

3. 获取 OpenJDK 自带的测试套。

```bash
git clone --depth=1 https://github.com/openjdk/jdk19u
```

4. 设置环境变量。

```bash
export JAVA_HOME=/lib/jvm/java-19-openjdk
export PATH=$JAVA_HOME/bin:$PATH
```

5. 获取并构建 jtreg。

```bash
git clone --depth=1 https://github.com/openjdk/jtreg
cd jtreg
sh make/build.sh
```

6. 执行测试套。

```bash
cd
export JT_HOME=$HOME/jtreg/build/images/jtreg
export PATH=$JT_HOME/bin:$PATH
jtreg -va -ignore:quiet -jit -conc:auto -timeout:5 -tl:3590 $HOME/jdk19u/test/jdk
```

### 预期结果

测试成功结束。

### 测试结果

测试结束，但出现部分失败/错误。jtreg 输出的日志存放在 JTreport 中，详见 [JTreport](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/JDK/testcases/jtreg-openjdk19/JTreport/index.html)。

> Note: 笔者执行测试时使用的测试套路径不同，详细结果中的路径与上述步骤可能有所偏差。这不会影响测试结果。

```log
Test results: passed: 9,167; failed: 1,677; error: 53
Report written to /home/openeuler/JTreport/html/report.html
Results written to /home/openeuler/JTwork
Error: Some tests failed or other problems occurred.
```

> TODO：部分可以解决的报错如下。

- 测试用例执行超时。修改 timeout 时限后重试。
- 未设置 X11 DISPLAY 变量。headless 环境下无法执行部分 GUI 测试。jtreg 执行这部分测试时依赖 vncserver 和 x11vnc。

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/JDK)

## 毕昇 JDK

暂无

# 其他

## 需求清单

| 名称                                      | 说明                                                                                                                                                                                                                                             | 安装文档 | 使用文档 | 已测试 | 测试用例 | 当前有包/可安装 | issues                                                                                                                                                                                                                                                                                                                                                          | 特性质量评估** | SIG 组                       | 负责人 |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- | -------- | ------ | -------- | --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ---------------------------- | ------ |
| A-Tune                                    | 无法启动                                                                                                                                                                                                                                         | Y        | Y        | N      | Y        | Y               | [I6R8CR](https://gitee.com/openeuler/RISC-V/issues/I6R8CR?from=project-issue)                                                                                                                                                                                                                                                                                   | ×              | A-Tune                       |        |
| secPaver                                  | oErv 不支持 SELinux，暂无法使用                                                                                                                                                                                                                  | Y        | \*       | Y      | Y        | Y               |                                                                                                                                                                                                                                                                                                                                                                 | ×              | sig-security-facility        |        |
| secGear                                   | 缺依赖 penlaisdk                                                                                                                                                                                                                                 | \*       | \*       | N      | N        | N               |                                                                                                                                                                                                                                                                                                                                                                 | ×              | sig-confidential-computing   |        |
| openGauss                                 | 不支持                                                                                                                                                                                                                                           | \*       | \*       | N      | N        | N               |                                                                                                                                                                                                                                                                                                                                                                 | ×              | DB                           |        |
| 用户态协议栈 gazelle                      | 缺包，不支持                                                                                                                                                                                                                                     | \*       | \*       | N      | N        | N               |                                                                                                                                                                                                                                                                                                                                                                 | 0              | sig-high-performance-network |        |
| 容器场景在离线混合部署 rubik              | 缺包，不支持                                                                                                                                                                                                                                     | \*       | \*       | N      | N        | N               |                                                                                                                                                                                                                                                                                                                                                                 | 0              | sig-CloudNative              |        |
| A-ops                                     | 部分依赖组件如 elasticsearch 不支持 RISC-V                                                                                                                                                                                                       | Y        | \*       | Y      | N        | Y               |                                                                                                                                                                                                                                                                                                                                                                 |                | sig-ops                      |        |
| IO 智能多流 astream                       |                                                                                                                                                                                                                                                  | Y        | \*       | N      | N        | Y               |                                                                                                                                                                                                                                                                                                                                                                 |                |                              |        |
| pkgship                                   | 有 redis 但 ElasticSearch 目前不支持 rv64，依赖不全无法启动                                                                                                                                                                                      | Y        | \*       | Y      | Y        | P               | [I6RR6R](https://gitee.com/openeuler/RISC-V/issues/I6RR6R) [I6RR83](https://gitee.com/openeuler/RISC-V/issues/I6RR83)                                                                                                                                                                                                                                           | 0              | sig-EasyLife                 |        |
| ROS/ROS2                                  | ROS 2 暂不支持                                                                                                                                                                                                                                   | N        | N        | N      | N        |                 |                                                                                                                                                                                                                                                                                                                                                                 |                | sig-ROS                      |        |
| 虚拟机热迁移                              | [QEMU 文档](https://www.qemu.org/docs/master/devel/migration.html)；[openEuler 文档](https://docs.openeuler.org/zh/docs/23.03/docs/Virtualization/%E7%83%AD%E8%BF%81%E7%A7%BB%E8%99%9A%E6%8B%9F%E6%9C%BA.html)                                   |          |          |        |          |                 |                                                                                                                                                                                                                                                                                                                                                                 |                | Virt                         |        |
| 虚拟化热补丁libcareplus                   | TODO: 官方测试工具；**可能需要针对 RISC-V 平台本身的一些特性进行测试**（e.g. ELF 重定位类型）                                                                                                                                                    | Y        | Y        | Y      | Y        | Y               |                                                                                                                                                                                                                                                                                                                                                                 | █              | sig-Virt                     |        |
| 定制裁剪工具(imageTailor和oemaker)        | 需要测试：目前不支持，后续如有发版生成镜像需要会做                                                                                                                                                                                               |          |          |        |          |                 |                                                                                                                                                                                                                                                                                                                                                                 |                | sig-OS-Builder               |        |
| 国密算法                                  | 需要测试，SM2/3/4 目前已加入内核 Kconfig                                                                                                                                                                                                         |          |          |        |          |                 |                                                                                                                                                                                                                                                                                                                                                                 |                | sig-security-facility?       |        |
| libstorage 针对 NVME 的 IO 栈             | 目前仅测试 libstorage 非 NVME 部分                                                                                                                                                                                                               | \*       | \*       | N      | N        |                 |                                                                                                                                                                                                                                                                                                                                                                 |                | ?                            |        |

## A-Tune

### 软件说明

A-Tune是一款基于AI的操作系统性能调优引擎。A-Tune利用AI技术，使操作系统“懂”业务，简化IT系统调优工作的同时，让应用程序发挥出色性能。

### 安装方法

#### 一、安装A-Tune

支持操作系统：openEuler 20.03 LTS 及以上版本

##### 使用 openEuler 默认自带的 A-Tune

```
dnf install atune
```

##### openEuler 20.09 及以上版本还需安装 atune-engine

```
dnf install atune-engine
```

**注：** 直接安装后尝试执行`systemctl start atuned`会出现报错信息，原因是未配置认证证书，解决方法如下：

1. 配置证书，使用https安全连接

- 生成服务端和客户端的证书文件，并
- 修改`/etc/atuned/atuned.cnf`中的60 ~ 62行、67 ~ 69行为证书文件的绝对路径，同时
- 修改`/etc/atuned/engine.cnf`中的23 ~ 25行为证书的绝对路径
- 相关证书生成方式可参考代码仓中`Makefile`文件的"restcerts"和"enginecerts"

2. 取消证书认证，使用http非安全连接

- 在安全要求不高的场景下（如本地测试使用等），可以通过使用http连接规避该问题
- 修改`/etc/atuned/atuned.cnf`中的rest_tls(L59)和engine_tls(L66)为false
- 修改`/etc/atuned/engine.cnf`中的engine_tls(L22)为false



#### 二、快速使用指南

##### 1、配置 A-Tune 服务

###### 修改atuned.cnf配置文件中网卡和磁盘的信息

注：如果通过'make install'安装了atuned服务，网卡和磁盘已经自动更新为当前机器中的默认设备。如果需要从其他设备收集数据，请按照以下步骤配置 atuned 服务。

通过以下命令可以查找当前需要采集或者执行网卡相关优化时需要指定的网卡，并修改/etc/atuned/atuned.cnf中的network配置选项为对应的指定网卡。

```
ip addr
```

通过以下命令可以查找当前需要采集或者执行磁盘相关优化时需要指定的磁盘，并修改/etc/atuned/atuned.cnf中的disk配置选项为对应的指定磁盘。

```
fdisk -l | grep dev
```

##### 2、管理 A-Tune 服务

###### 加载并启动atuned和atune-engine服务

```
systemctl daemon-reload
systemctl start atuned
systemctl start atune-engine
```

**注意**：此处 ```systemctl start atuned``` 启动失败，相关 issue：https://gitee.com/openeuler/RISC-V/issues/I6R8CR

###### 查看atuned或atune-engine服务状态

```
systemctl status atuned
systemctl status atune-engine
```

### 参考资料

[openEuler Docs 22.03 LTS SP1 - A-Tune 用户指南](https://docs.openeuler.org/zh/docs/22.03_LTS_SP1/docs/A-Tune/A-Tune.html)

## secPaver

### 软件说明

secPaver是一个帮助管理员定义应用程序安全策略的工具。用户可以使用secPaver为应用程序生成不同安全机制下的策略文件。

目前secPaver支持的安全机制为SELinux，AppArmor即将支持，不同的安全机制生成模块以插件（plugin）形式加载。

### 安装 secpaver

``` bash
sudo dnf install secpaver
```
### 下载源码

测试文件位于 tests 目录
``` bash
git clone https://gitee.com/openeuler/secpaver
cd secpaver/tests
```

### 测试

```
sudo systemctl start pavd
bash test.sh
```

### 参考资料

https://gitee.com/openeuler/secpaver

https://gitee.com/openeuler/secpaver/blob/master/doc/manual.md

https://gitee.com/openeuler/secpaver/blob/master/doc/cmd.md

### 测试结果

当前 openEuler risc-v 不支持 selinux
且 pavd 无法使用 [相关问题](https://gitee.com/openeuler/RISC-V/issues/I6R07N) 。

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/secPaver)

## secGear

### 软件说明

secGear 是面向计算产业的机密计算安全应用开发套件，旨在方便开发者在不同的硬件设备上提供统一开发框架。目前 secGear 支持 Intel SGX 硬件，Trustzone itrustee，以及 RISC-V 蓬莱 TEE。

### 安装方法

``` bash
sudo dnf install secGear-devel
```

## 参考资料

[openEuler Docs 23.03 - 安装 secGear]https://docs.openeuler.org/zh/docs/23.03/docs/secGear/%E5%AE%89%E8%A3%85secGear.html

### 测试结果

目前 openEuler RISC-V 缺少相关软件包，无法安装。

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/secGear)

## openGauss

不支持

## 用户态协议栈 gazelle

缺包，不支持

## 容器场景在离线混合部署 rubik

缺包，不支持

## A-ops

### 软件说明

A-Ops 是 openEuler 的一套智能运维框架。

### 环境配置

> 注意：A-Ops 需要两台机器用于部署。

机器 A：
- 硬件信息：赛昉科技 昉·星光 2 / StarFive VisionFive 2 4GB
- 操作系统版本：openEuler 23.03 riscv64, Linux 5.15.0-7.oe2303.riscv64
- 软件版本：aops-tools-v1.1.1-2.oe2303.riscv64

机器 B：
- 硬件信息：HiFive Unmatched
- 操作系统版本：openEuler 23.03 riscv64, Linux 6.1.0-10.oe2303.riscv64
- 软件版本：aops-tools-v1.1.1-2.oe2303.riscv64

### 运行步骤

#### 机器 A

请以 root 用户登录，或执行切换至 root 用户然后再执行如下操作。

1. 安装 A-Ops 及其依赖包：

```bash
dnf install -y aops-tools
```

2. 部署 MySQL：

```bash
/opt/aops/scripts/aops-basedatabase mysql
```

3. 修改 MySQL 配置文件：

查看本机 IP，并添加进 MySQL 的配置文件中。

```bash
ip a
```

修改 `/etc/my.cnf`，在 [mysqld] 字段新增 `bind-address`，值为上一步获取到的本机 IP。

```
[mysqld]
...
bind-address=xx.xx.xx.xx
...
```

修改完成后，重启 `mysqld.service`：`sudo systemctl restart mysqld.service`

4. 连接数据库，设置权限：

```bash
mysql
show databases;
use mysql;
select user,host from user; //出现user为root，host为localhost时，说明mysql只允许本机连接，外网和本地软件客户端则无法连接。
update user set host = '%' where user='root';
flush privileges; //刷新权限
exit
```

5. 部署 ElasticSearch：

```bash
/opt/aops/scripts/aops-basedatabase elasticsearch
```

6. 修改 ElasticSearch 配置文件：

```bash
vim /etc/elasticsearch/elasticsearch.yml
```

修改其中的 `node.name`, `network.host`, `http.port`, `cluster.initial_master_nodes` 项：
```
node.name: node-1
network.host: xx.xx.xx.xx
http.port: 9200
cluster.initial_master_nodes: ["node-1"]
```

修改完成后重启 ElasticSearch 服务：
```bash
systemctl restart elasticsearch
```

6. 安装 aops-manager：

```bash
dnf install -y aops-manager
```

修改配置文件 `vim /etc/aops/manager.ini`：

```ini
[manager]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=11111
host_vault_dir=/opt/aops
host_vars=/opt/aops/host_vars

[uwsgi]
wsgi-file=manage.py
daemonize=/var/log/aops/uwsgi/manager.log
http-timeout=600
harakiri=600

[elasticsearch]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=9200
max_es_query_num=10000000

[mysql]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=3306
database_name=aops
engine_format=mysql+pymysql://@%s:%s/%s
pool_size=10000
pool_recycle=7200

[aops_check]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=11112
```

启动 `aops-manager` 服务：

`systemctl start aops-manager`

7. 安装 aops-web：

```
dnf install -y aops-web
```

修改配置文件，由于将所有服务都部署在机器 A，故需将 web 访问的各服务地址配置成机器 A 的真实 IP。

```
vim /etc/nginx/aops-nginx.conf
```

部分服务配置：

```conf
# 保证前端路由变动时 nginx 仍以 index.html 作为入口
location / {
  try_files $uri $uri/ /index.html;
  if (!-e $request_filename){
    rewrite ^(.*)$ /index.html last;
  }
}

location /api/ {
  proxy_pass http://192.168.1.1:11111/;
}

location /api/domain {
  proxy_pass http://192.168.1.1:11114/;
  rewrite ^/api/(.*) /$1 break;
}

location /api/host {
  proxy_pass http://192.168.1.1:11114/;
  rewrite ^/api/(.*) /$1 break;
}
```

开启 `aops-web` 服务：

```bash
systemctl start aops-web
```

8. 部署 kafka

安装：

```
dnf install kafka
```

修改配置文件：

```
vim /opt/kafka/config/server.properties
```

将listener 改为本机ip：

```
listeners=PLAINTEXT://192.168.1.1:9092
```

启动kafka服务: 

```
cd /opt/kafka/bin
nohup ./kafka-server-start.sh ../config/server.properties &
tail -f ./nohup.out  # 查看nohup所有的输出出现A本机ip 以及 kafka启动成功INFO；
```

9. 部署aops-check

安装aops-check：

```
dnf install aops-check
```

修改配置文件：

```
vim /etc/aops/check.ini
```

将配置文件中各服务的地址修改为真实地址，由于将所有服务都部署在机器A，故需把IP地址配为机器A的地址。

```
[check]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=11112
mode=configurable  // 该模式为configurable模式，用于常规诊断模式下的调度器。
timing_check=on

[default_mode]
period=30
step=30

[elasticsearch]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=9200

[mysql]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=3306
database_name=aops
engine_format=mysql+pymysql://@%s:%s/%s
pool_size=10000
pool_recycle=7200

[prometheus]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=9090
query_range_step=15s

[agent]
default_instance_port=8888

[manager]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=11111

[consumer]
kafka_server_list=192.168.1.1:9092  // 此处及后续服务ip修改为机器A真实ip
enable_auto_commit=False
auto_offset_reset=earliest
timeout_ms=5
max_records=3
task_name=CHECK_TASK
task_group_id=CHECK_TASK_GROUP_ID
result_name=CHECK_RESULT
[producer]
kafka_server_list = 192.168.1.1:9092  // 此处及后续服务ip修改为机器A真实ip
api_version = 0.11.5
acks = 1
retries = 3
retry_backoff_ms = 100
task_name=CHECK_TASK
task_group_id=CHECK_TASK_GROUP_ID
```

启动aops-check服务（configurable模式）：

```
systemctl start aops-check
```

10. 部署客户端服务

客户端机器的服务需要部署aops-agent及gala-gopher，具体可参考[aops-agent部署指南](aops-agent部署指南.md)。

注意：主机注册时需要先在前端添加主机组操作，确保该主机所属的主机组存在。此处只对机器A做部署、纳管。

11. 部署 prometheus

安装prometheus:

```
dnf install prometheus2
```

修改配置文件：

```
vim /etc/prometheus/prometheus.yml
```

将所有客户端的gala-gopher地址新增到prometheus的监控节点中。

```yaml
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090', '192.168.1.1:8888']
```

启动服务：

```
systemctl start prometheus
```

12. 部署gala-ragdoll

A-Ops配置溯源功能依赖gala-ragdoll实现，通过Git实现配置文件的变动监测。

安装gala-ragdoll：

```shell
dnf install gala-ragdoll # A-Ops 配置溯源
```

修改配置文件：

```shell
vim /etc/ragdoll/gala-ragdoll.conf
```

将collect节点collect_address中IP地址修改为机器A的地址，collect_api与collect_port修改为实际接口地址。

```
[git]
git_dir = "/home/confTraceTest"
user_name = "user_name"
user_email = "user_email"

[collect]
collect_address = "http://192.168.1.1"    //此处修改为机器A的真实IP
collect_api = "/manage/config/collect"    //此处修改为配置文件采集的实际接口
collect_port = 11111                      //此处修改为服务的实际端口

[sync]
sync_address = "http://0.0.0.0"
sync_api = "/demo/syncConf"
sync_port = 11114


[ragdoll]
port = 11114

```

启动gala-ragdoll服务：

```shell
systemctl start gala-ragdoll
```

#### 机器 B

1. 安装 `aops-check`：

```bash
dnf install aops-check
```

2. 修改配置文件：`vim /etc/aops/check.ini`

将配置文件中各服务的地址修改为真实地址，除check服务为机器B的地址外，其他服务都部署在机器A，故需把IP地址配置为机器A的地址即可。

```ini
[check]
ip=192.168.1.2  // 此处ip改为机器B真实ip
port=11112
mode=executor  // executor，用于常规诊断模式下的执行器
timing_check=on

[default_mode]
period=30
step=30

[elasticsearch]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=9200

[mysql]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=3306
database_name=aops
engine_format=mysql+pymysql://@%s:%s/%s
pool_size=10000
pool_recycle=7200

[prometheus]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=9090
query_range_step=15s

[agent]
default_instance_port=8888

[manager]
ip=192.168.1.1  // 此处及后续服务ip修改为机器A真实ip
port=11111

[consumer]
kafka_server_list=192.168.1.1:9092  // 此处及后续服务ip修改为机器A真实ip
enable_auto_commit=False
auto_offset_reset=earliest
timeout_ms=5
max_records=3
task_name=CHECK_TASK
task_group_id=CHECK_TASK_GROUP_ID
result_name=CHECK_RESULT
[producer]
kafka_server_list = 192.168.1.1:9092  // 此处及后续服务ip修改为机器A真实ip
api_version = 0.11.5
acks = 1
retries = 3
retry_backoff_ms = 100
task_name=CHECK_TASK
task_group_id=CHECK_TASK_GROUP_ID
```

启动 `aops-check` 服务（`executor` 模式）：

```bash
systemctl start aops-check
```

至此，部署完成。

### 参考资料

[openEuler Docs 22.09 - A-Ops 用户指南](https://docs.openeuler.org/zh/docs/22.09/docs/A-Ops/overview.html)

### 测试结果

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test/A-Ops)

#### 预期结果

成功按上述步骤部署 A-Ops。

#### 实际结果

缺少部分组件，未能成功部署。仅成功使用 A-ops 安装 MySQL，未安装其他组件。

|  软件包名称  |  失败原因   |
|-------------|------------|
|elasticsearch|不支持 RISC-V|
|aops-manager |  软件包缺失 |
|  aops-web   |  软件包缺失 |
|  zookeeper  |  软件包缺失 |
|    kafka    |  软件包缺失 |
| aops-check  |  软件包缺失 |

## IO 智能多流 

### 软件说明

astream是一款支持用户自定义配置目标文件的流信息，以使能NVMe SSD磁盘的多流（multi-stream）特性，从而延长磁盘寿命的便捷工具。

### 安装方法
```
dnf install astream
```
### 参考资料
https://gitee.com/openeuler/astream

[openEuler Docs 23.03 - atream 用户指南](https://docs.openeuler.org/zh/docs/23.03/docs/astream/overview.html)

### 测试结果

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/astream)

## pkgship

### 软件说明

pkgship是一款管理OS软件包依赖关系，提供依赖和被依赖关系完整图谱的查询工具，pkgship提供软件包依赖查询、生命周期管理、补丁查询等功能。

1. 软件包依赖查询：方便社区人员在软件包引入、更新和删除的时候了解软件的影响范围。
2. 补丁查询：方便社区人员了解openEuler软件包的补丁情况以及提取补丁内容，详细内容请参见[patch-tracking](https://docs.openeuler.org/zh/docs/22.03_LTS_SP1/docs/userguide/patch-tracking.html)。

### 环境配置

```
Name         : pkgship
Version      : 3.0.0
Release      : 1.oe2303
Architecture : noarch
Size         : 800 k
Source       : pkgship-3.0.0-1.oe2303.src.rpm
Repository   : @System
From repo    : mainline
Summary      : Pkgship implements rpm package dependence ,maintainer, patch query and so on.
URL          : https://gitee.com/openeuler/pkgship
License      : Mulan 2.0
Description  : Pkgship implements rpm package dependence ,maintainer, patch query and so no.
```

### 安装方法

```
sudo dnf install pkgship
```

### 测试方法

可以安装成功,但是无法运行其一个脚本使其服务启动

mugen 有相关测试套

### 相关 issue

- [#I6RR6R 23.02pkgship服务启动失败](https://gitee.com/openeuler/RISC-V/issues/I6RR6R)
- [#I6RR83 23.02pkgship安装elasticsearch失败](https://gitee.com/openeuler/RISC-V/issues/I6RR83)

提问相关的:

- [#I6QLEL 请问openEuler这边对pkgship使用什么样的方法进行功能测试](https://gitee.com/openeuler/pkgship/issues/I6QLEL)

### 参考资料

[openEuler Docs 23.03 - pkgship](https://docs.openeuler.org/zh/docs/23.03/docs/userguide/pkgship.html)

## mindspore

仓库暂未支持这款软件

## pod 带宽管理 oncn-bwm

### 软件说明

oncn-bwm 是一款适用于离线业务混合部署场景的 Pod 带宽管理工具，它会根据 QoS 分级对节点内的网络资源进行合理调度，保障在线业务服务体验的同时，大幅提升节点整体的网络带宽利用率。

oncn-bwm 工具支持如下功能：

- 使能/去除/查询 Pod 带宽管理
- 设置 Pod 网络优先级
- 设置离线业务带宽范围和在线业务水线
- 内部统计信息查询

### 摘要

oncn-bwm 工具提供了 `bwmcli` 命令行工具来使能 Pod 带宽管理或进行相关配置。

### 安装方法

```bash
sudo dnf install -y oncn-bwm
```

### 运行步骤

Shell 运行：

```bash
ip link #查看网卡名称
sudo bwmcli -e eth0 #开启 eth0 的 Pod 带宽管理
```

### 参考资料
[openEuler Docs 22.09 - oncn-bwm 用户指南](https://docs.openeuler.org/zh/docs/22.09/docs/oncn-bwm/overview.html)

### 测试结果

[仓库](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/System_and_Feature_Test/oncn-bwm)

#### 预期结果

成功开启带宽管理：`enable eth0 success`

#### 实际结果

未能成功开启带宽管理。

## ROS/ROS2

ROS 2 暂不支持

## 高性能服务网格数据面 Kmesh

oErv 暂不支持，软件包缺失

## 虚拟机热迁移

暂无

## 虚拟化热补丁 libcareplus

### 软件说明

LibcarePlus 是一个用户态进程热补丁框架，可以在不重启进程的情况下对 Linux 系统上运行的目标进程进行热补丁操作。热补丁可以应用于 CVE 漏洞修复，也可以应用于不中断应用服务的紧急 bug 修复。

### 环境配置

- 硬件信息：QEMU 7.2.1 on Arch Linux (WSL 2)，8*vCPU + 8GB RAM
- 操作系统版本：openEuler 23.03 preview riscv64, Linux 6.1.19-2.oe2303.riscv64
- 软件版本：iSulad-2.1.1-7.oe2303.riscv64

### 参考资料

[openEuler Docs 23.03 - LibcarePlus](https://docs.openeuler.org/zh/docs/23.03/docs/Virtualization/LibcarePlus.html#%E5%AE%89%E8%A3%85-libcareplus)

## 定制裁剪工具 (imageTailor和oemaker)

目前不支持，后续如有发版生成镜像需要会做

## 国密算法

需要测试，SM2/3/4 目前已加入内核 Kconfig

## libstorage 针对 NVME 的 IO 栈

目前仅测试 libstorage 非 NVME 部分

# 参考文献

1. [openEuler RISC-V 23.03 测试](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/README.md)
2. [what_is_this](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month0/what-is-this.md)
