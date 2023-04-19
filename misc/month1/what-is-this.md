## Currently tested & WIP

|名称|说明|安装文档|使用文档|已测试|测试用例|当前有包/可安装|可用性**|issues|SIG 组|
|-|-|-|-|-|-|-|-|-|-|
|UKUI|较为卡顿，需要 GPU 的部分窗口特效可能无法启动(TODO)|Y|Y|Y|Y|Y|6|[I6TGR9](https://gitee.com/openeuler/RISC-V/issues/I6TGR9) [I6O31D](https://gitee.com/openeuler/RISC-V/issues/I6O31D) [I6Q24G](https://gitee.com/openeuler/RISC-V/issues/I6Q24G) [I6Q27C](https://gitee.com/openeuler/RISC-V/issues/I6Q27C)|
|DDE|使用手册待补完|Y|Y|Y|Y|Y|0|[I6VGN4](https://gitee.com/openeuler/RISC-V/issues/I6VGN4)|
|xfce|镜像自带|Y|Y|
|GNOME||||||Y||[I6QETO](https://gitee.com/openeuler/RISC-V/issues/I6QETO) [I6QETK](https://gitee.com/openeuler/RISC-V/issues/I6QETK) [I6QETA](https://gitee.com/openeuler/RISC-V/issues/I6QETA) [I6QET6](https://gitee.com/openeuler/RISC-V/issues/I6QET6) [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY?from=project-issue#note_17078724_link)|
|Kiran||Y|Y|Y|Y|Y||[I6OZ5N](https://gitee.com/openeuler/RISC-V/issues/I6OZ5N) [I6OYL4](https://gitee.com/openeuler/RISC-V/issues/I6OYL4) [I6WHYU](https://gitee.com/openeuler/RISC-V/issues/I6WHYU)|
|Cinnamon|使用手册待补完，绝大部分应用从桌面无法直接启动|Y|*|Y|Y|Y|3| [I6QV1V](https://gitee.com/openeuler/RISC-V/issues/I6QV1V?from=project-issue) [I6QUT1](https://gitee.com/openeuler/RISC-V/issues/I6QUT1?from=project-issue) [I6QV8A](https://gitee.com/openeuler/RISC-V/issues/I6QV8A?from=project-issue) [I6QVEN](https://gitee.com/openeuler/RISC-V/issues/I6QVEN) [I6QVV6](https://gitee.com/openeuler/RISC-V/issues/I6QVV6)|
|容器(isula/docker/安全容器/系统容器/镜像)|见 [I6QQLB](https://gitee.com/openeuler/iSulad/issues/I6QQLB) 有 iSulad sig 官方的黑盒测试工具；iSulad新增native network 特性|Y|Y|Y|Y|P|8|
|编译器 (gcc/jdk)|gcc 完成，jdk 缺少 jtreg; 基于开源测试套对 gcc 和 jdk 相关功能进行验证;(GCC 编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能)|P|*|P|P|P|
|HA/高可用|安装成功|Y|Y|N|Y|Y|
|KubeSphere|[安装文档](https://docs.openeuler.org/zh/docs/23.03/docs/desktop/kubesphere.html)
|OpenStack Train & Wallaby|
|A-Tune|无法启动|Y|Y|N|Y|Y|0|
|secPaver|oErv 不支持 SELinux，暂无法使用|Y|*|Y|Y|Y|0|
|secGear|缺依赖 penlaisdk|*|*|N|N|N|0|
|eggo||*|*|N|N|Y|
|kubeOS||*|*|N|N|Y|
|NestOS|
|OpenResty||Y|Y|N|Y|Y|
|etmem|启动失败|*|*|N|N|Y|0|
|openGauss|不支持|*|*|N|N|N|0|
|用户态协议栈 gazelle|缺包，不支持|*|*|N|N|N|0|
|容器场景在离线混合部署 rubik|缺包，不支持|*|*|N|N|N|0|
|A-ops||Y|*|N|N|Y|
|k3s|23.03 需要回归测试|Y|*|N|N|Y|
|IO 智能多流 astream||Y|*|N|N|Y|
|pkgship|有 redis 但 ElasticSearch 目前不支持 rv64，依赖不全无法启动|Y|*|Y|Y|P|0|
|mindspore|缺包，不支持|*|*|N|N|N|0|
|pod 带宽管理 oncn-bwm||*|*|N|N|Y|
|kubernetes||Y|*|Y|Y|Y|
|ROS/ROS2|ROS 2 暂不支持|N|N|N|N|
|kconfigDetector|OBS 已有且构建成功，暂未进源|Y|Y|Y|Y|Y|
|使用开源测试套LTP/mmtest||||||||sig-kernel/sig-QA
|【openEuler 23.03】新增高性能服务网格数据面Kmesh|[官方文档-23.03](https://docs.openeuler.org/zh/docs/23.03/docs/Kmesh/%E4%BD%BF%E7%94%A8%E6%96%B9%E6%B3%95.html)
|【openEuler 23.03】 虚拟机热迁移|[QEMU 文档](https://www.qemu.org/docs/master/devel/migration.html);[openEuler 文档](https://docs.openeuler.org/zh/docs/23.03/docs/Virtualization/%E7%83%AD%E8%BF%81%E7%A7%BB%E8%99%9A%E6%8B%9F%E6%9C%BA.html)|

## What is this?

|名称|说明|安装文档|使用文档|已测试|测试用例|当前有包/可安装|可用性**|issues|SIG 组|
|-|-|-|-|-|-|-|-|-|-|
|虚拟化 Virt|优先级低，目前市面上尚无支持虚拟化的 RISC-V 硬件|Y|*|N|N|Y|||sig-Virt|
|虚拟化热补丁libcareplus|23.02 可用（仅测试针对单个程序打 hot patch），23.03 TBD，需要请教其他老师|*|*|N|N|Y|||sig-Virt|
|DPU虚机热迁移：内核态vDPA支持，异构网卡直通|不支持，前序依赖包括但不限于虚拟化||||||||sig-Virt|
|定制裁剪工具(imageTailor和oemaker)|目前不支持，后续可能会做||||||||sig-OS-Builder|
|安装部署，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署|目前不支持，后续会做||||||||?|
|直连聚合虚机管理无感卸载|不支持，前序依赖包括但不限于虚拟化||||||||sig-Virt|
|libstorage 针对 NVME 的 IO 栈|需要请教其他老师|*|*|N|N||||?|
|国密算法|SM2/4 大概支持？SM3 需要刷新一下 kernel||||||||sig-security-facility?|
|支持基于分布式软总线扩展生态互联互通|dsoftbus 的包还没人修||||||||sig-Embedded|
|支持混合关键部署技术扩展|OpenAMP 的包能打出来，不过虚拟化相关内容可能还得再考虑一下||||||||sig-Embedded|
|支持硬实时系统|目前没有人看 rt 相关的事情||||||||sig-ROS?|
|新增备份还原功能支持|需要请教其他老师||||||||sig-Migration?|
|新增ROS基础版和ROS2基础版|需要请教其他老师||||||||sig-ROS|
||验证dde桌面支持能力,基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常||||||||sig-Migration???|

Note:

*: 可参考上游官方文档补全。

\**: 可用性从低到高 0~10，0 = 完全不可用（e.g. 无法启动/无法安装），10 = **流畅**使用无 Bug，其余 = 有 Bug / 需要 workaround，视 Bug 严重程度 & workaround 操作复杂度打分；以此类推。

> TODO: 后续可能细化评分标准。