# week 1

## 工作内容

接手 openEuler 23.03 的部分测试工作。

All Projects: 目录/链接可能需要更新（目录结构有变化）

缺陷：详见 [openeuler-riscv-2303-test](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test) (on Gitee)

|名称|说明|状态|
|-|-|:-:|
|UKUI|安装方法&使用手册待补完，23.03 下目前可能无法使用，需要回归测试|WIP|
|gcc/jdk|缺包，官方测试用例暂时无法使用|×?|
|secPaver|缺少 SELinux 无法运行|×|
|secGear|缺失 penglai SDK 无法运行|×|
|eggo||TBD|
|OpenResty||TBD|
|IO 智能多流 astream|可安装，未测试|WIP|
|GNOME|lightDM 有问题（降级内核可救），GDM 也有问题，有部分包缺依赖（可能已修复，需要回归测试）|WIP|
|iSula(d)|官方提供的黑盒测试工具暂未使用，其他部分测试已基本完成|WIP|
|HA 软件/高可用|可安装，需要至少两台机器，QEMU 下可能需要较复杂的网络配置|WIP|
|A-Ops||TBD|
|ROS|ROS2 oErv 暂无支持|×|
|kconfigDetector|oErv 源不提供，Python 程序，可直接运行，有报错|WIP|
|iSulad native network||WIP|
|Unmatched hwtest||TBD|
|mugen||TBD|
|Kiran 桌面|可正常使用，文档待合并|WIP|
|新增备份还原功能||TBD|
|OpenStack Train & Wallaby||TBD|
|定制裁剪工具 imageTailor, oemaker|镜像源软件包缺失|×|
|k3s|安装过程中有报错，23.03 下需要回归测试|WIP|
|pkgship|可安装，服务启动失败|WIP|
|mindspore|软件源不提供|x|
|kubernetes (k8s)|可安装，自动测试失败，文档需要补完|WIP|
|DDE|可能需要降级内核|WIP|
|Cinnamon|23.03 需要回归测试|WIP|
|virt|可安装，功能未测试，先前版本基本成功|WIP|
|A-Tune|可安装，不可用|×|
|etmem|modprobe 报错|×|
|rubik|软件源不提供，缺少文档|×|
|libstorage||TBD|
|pod 带宽管理 oncn-bwm||TBD|