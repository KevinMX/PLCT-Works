# week 4

## 本周工作

### RuyiSDK

#### 调研

##### HiFive Unmatched / FU740

- Zephyr on HiFive Unmatched [安装文档](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month10/Zephyr_Unmatched.md)
- openEuler 23.09 [安装文档¹（同 23.03）](https://gitee.com/openeuler/RISC-V/tree/master/release/openEuler-23.03/Installation_Book/Unmatched) | [安装文档²（包括分区扩容步骤）](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.09-V1-riscv64/Unmatched/README.unmatched.txt) | [系统镜像](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/preview/openEuler-23.09-V1-riscv64/Unmatched/)
- Armbian: 官网镜像直接写入后无法启动，镜像内只分了 rootfs 一个分区，没有给 bootloader 分区
- Ubuntu: 测试可用 [安装文档](https://wiki.ubuntu.com/RISC-V/SiFive%20HiFive%20Unmatched)
- OpenKylin (v1.0): [安装文档](https://docs.openkylin.top/zh/%E7%A4%BE%E5%8C%BA%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97/riscv%E4%B8%8A%E5%AE%89%E8%A3%85openKylin)
- OpenSUSE: [系统镜像](https://download.opensuse.org/ports/riscv/tumbleweed/images/)
  - 启动后进入了 Emergency 模式，分区挂载失败？
- Debian: [安装文档](https://wiki.debian.org/InstallingDebianOn/SiFive/%20HiFiveUnmatched)
  - 使用的镜像：https://github.com/yuzibo/Unmatched-Debian-image/
  - 必须插入网线，否则 U-Boot 会无限卡在协商网络上
  - 可正常启动，但默认密码不正确，未能登录
  - 尝试安装了一块 Radeon HD6750，因默认未安装 radeon 固件，出现了 Kernel Tainted 的情况
- FreeBSD: [安装步骤&屏幕截图](https://github.com/ruyisdk/ruyi/issues/65#issuecomment-1970489466)
  - openBSD: 步骤完全一致，使用 [install74.img](https://mirrors.tuna.tsinghua.edu.cn/OpenBSD/7.4/riscv64/install74.img) 镜像

#### RuyiSDK 测试

##### v0.5.0

- Milk-V Pioneer Box (v1.3) oERV 23.09 / ruyi 0.5.0 版本测试报告 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240224/oERV2309-SG2042-Pioneer.md)
- HiFive Unmatched 镜像刷写报告（openEuler + OpenWrt）[Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240224/HiFive_Unmatched-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)

##### mugen 自动化测试

- 修复 `ruyi_test_gnu-plct-rv64ilp32-elf` 意外失败/未能正常创建源码文件的问题 [commit](https://github.com/weilinfox/ruyi-mugen/commit/d7fa8153e47ea7db475206f9559398ebd2764c16)
