# week 1

## 工作内容

接手 openEuler 23.03 的部分测试工作。

All Projects: 目录/链接可能需要更新（目录结构有变化）

缺陷：详见 [openeuler-riscv-2303-test](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test) (on Gitee)

### WIP/TBD List

*: 可参考上游官方文档补全。

\**: 可用性从低到高 0~10，0 = 完全不可用（e.g. 无法启动/无法安装），10 = **流畅**使用无 Bug，其余 = 有 Bug / 需要 workaround，视 Bug 严重程度 & workaround 操作复杂度打分；以此类推。

> TODO: 后续可能细化评分标准。

|名称|说明|安装文档|使用文档|已测试|测试用例|当前有包/可安装|可用性**|
|-|-|-|-|-|-|-|-|
|UKUI|较为卡顿，需要 GPU 的部分窗口特效可能无法启动(TODO)|Y|*|Y|Y|Y|6|
|DDE|使用手册待补完|Y|Y|Y|Y|Y|0|
|Kiran|使用手册待补完|Y|*|Y|Y|Y|
|Cinnamon|使用手册待补完，绝大部分应用从桌面无法直接启动|Y|*|Y|Y|Y|3|
|虚拟化 Virt||Y|*|N|N|Y|
|编译器 (gcc/jdk)|gcc 完成，jdk 缺少 jtreg|P|*|P|P|P
|HA/高可用|安装成功|Y|Y|N|Y|Y|
|A-Tune|无法启动|Y|Y|N|Y|Y|0|
|secPaver|oErv 不支持 SELinux，暂无法使用|Y|*|Y|Y|Y|0|
|secGear|缺依赖 penlaisdk|*|*|N|N|N|0|
|eggo||*|*|N|N|Y|
|kubeOS||*|*|N|N|Y|
|OpenResty||Y|Y|N|Y|Y|
|etmem|启动失败|*|*|N|N|Y|0|
|openGauss|不支持|*|*|N|N|N|0|
|libcareplus|23.02 可用（仅测试针对单个程序打 hot patch），23.03 TBD|*|*|N|N|Y|
|用户态协议栈 gazelle|缺包，不支持|*|*|N|N|N|0|
|容器场景在离线混合部署 rubik|缺包，不支持|*|*|N|N|N|0|
|A-ops||Y|*|N|N|Y|
|libstorage 针对 NVME 的 IO 栈||*|*|N|N|
|k3s|23.03 需要回归测试|Y|*|N|N|Y|
|IO 智能多流 astream||Y|*|N|N|Y|
|pkgship|有 redis 但 ElasticSearch 目前不支持 rv64，依赖不全无法启动|Y|*|Y|Y|P|0|
|mindspore|缺包，不支持|*|*|N|N|N|0|
|pod 带宽管理 oncn-bwm||*|*|N|N|Y|
|kubernetes||Y|*|Y|Y|Y|
|ROS/ROS2|ROS 2 暂不支持|N|N|N|N|
|kconfigDetector|OBS 已有且构建成功，暂未进源|Y|Y|Y|Y|Y|

### 下周计划

- 补全 UKUI、Kiran、libcareplus 文档 & 测试用例；
- 补全已测试软件包的详细结果，如有缺陷未提交，则提交 issue；
- 测试 libcareplus 和 kconfigDetector。
