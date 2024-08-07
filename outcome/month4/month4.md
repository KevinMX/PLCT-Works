# month 4

记录本月产出。

1. 基于 openEuler 23.09 RISC-V testing v0.1 镜像进行测试。

- 功能测试
    - [LTP](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/BasicTest/function/LTP)
- 编译器测试
    - [dejagnu](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/BasicTest/compilers/dejagnu)
    - [yarpgen](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/BasicTest/compilers/yarpgen)
    - [csmith](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/BasicTest/compilers/csmith)
    - [AnghaBench](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/BasicTest/compilers/AnghaBench)
- 长稳测试
    - [LTP Long stress](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/BasicTest/long_stress/LTPStress)

详情见 https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test 。

2. 完成 ROS 2 Humble 在 HiFive Unmatched & openEuler RISC-V 22.03 上的测试，并编写测试报告。
    - https://gitee.com/yunxiangluo/open-euler-risc-v-ros2-humble/tree/master/Unmatched

3. 参加 TARSIER 开放日 & RISC-V 中国峰会，在 RVSC 算能展台参与服务器 Demo 运行、服务器调试/运维、现场解说（包括对外籍嘉宾的解说）等工作。

4. 部署&简单测试 openEuler 上游新发布的 openEuler 23.09 RC1 QEMU qcow2 镜像，发现了如下可能影响使用和测试的问题（在 Alpha 镜像也存在）：

    - 网络服务默认配置存在问题，无法连接网络，外部也无法通过 SSH 连入。需要手动启用并启动 `NetworkManager`。
        - 解决方案：`systemctl enable --now NetworkManager`
    - 23.09 版本起引入了一个[安全配置](https://gitee.com/src-openeuler/setup/pulls/20)，会话超时时间 300 秒，这会导致测试中断。
        - 解决方案：移除 `/etc/profile` 中的 `export TMOUT=300`。
    - 默认仅配置了 `root` 用户，需要非 `root` 用户的场合，需要自行添加。
    - 默认软件源配置错误，需要手动修改：
    `sed -i 's/repo.openeuler.org\/openEuler-23.09\//121.36.84.172\/dailybuild\/EBS-openEuler-23.09\/rc1_openeuler-2023-08-23-20-06-19\//g' /etc/yum.repos.d/openEuler.repo`

5. 23.09 x86_64 QEMU KVM 启动脚本：[/misc/month4/start_vm_x86.sh](https://raw.githubusercontent.com/KevinMX/PLCT-Tarsier-Works/main/misc/month4/start_vm_x86.sh)

> 需要宿主机安装 `edk2-ovmf` 或发行版其他提供了 edk2 固件的软件包，并将 `/usr/share/edk2-ovmf/x64/OVMF.fd` 复制到 `qcow2` 镜像同级目录下。