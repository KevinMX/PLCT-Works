# week 1

## 工作内容

接手 openEuler 23.03 的部分测试工作。

All Projects: 目录/链接可能需要更新（目录结构有变化）

缺陷：详见 [openeuler-riscv-2303-test](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test) (on Gitee)

### WIP/TBD List

*: 可参考上游官方文档补全。

|名称|说明|安装文档|使用文档|已测试|测试用例|
|-|-|-|-|-|-|
|UKUI|使用手册待补完|Y|*|Y|Y|
|DDE|使用手册待补完|Y|Y|Y|Y|
|Kiran|使用手册待补完|Y|*|Y|Y|
|Cinnamon|使用手册待补完|Y|*|Y|Y|
|虚拟化 Virt||Y|*|N|N|
|编译器 (gcc/jdk)|gcc 完成，jdk 缺少 jtreg|P|*|P|P|
|HA/高可用|安装成功|Y|Y|N|Y|
|A-Tune|无法启动|Y|Y|N|Y|
|secPaver|oErv 不支持 SELinux，暂无法使用|Y|*|Y|Y|
|secGear|缺依赖 penlaisdk|*|*|N|N|
|eggo||*|*|N|N|
|kubeOS||*|*|N|N|
|OpenResty||Y|Y|N|Y|
|etmem|启动失败|*|*|N|N|
|openGauss|不支持|*|*|N|N|
|libcareplus||*|*|N|N|
|用户态协议栈 gazelle|缺包，不支持|*|*|N|N|
|容器场景在离线混合部署 rubik|缺包，不支持|*|*|N|N|
|A-ops||Y|*|N|N|
|libstorage 针对 NVME 的 IO 栈||*|*|N|N|
|k3s|23.03 需要回归测试|Y|*|N|N|
|IO 智能多流 astream||Y|*|N|N|
|pkgship|无法启动|Y|*|Y|Y|
|mindspore|缺包，不支持|*|*|N|N|
|pod 带宽管理 oncn-bwm||*|*|N|N|
|kubernetes||Y|*|Y|Y|
|ROS/ROS2|ROS 2 暂不支持|N|N|N|N|
|kconfigDetector||Y|Y|Y|Y|