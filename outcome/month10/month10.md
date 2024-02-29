# Month 10

记录本月产出。

## RuyiSDK

### 调研

#### HiFive Unmatched / FU740

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

### RuyiSDK 测试

#### v0.4.0

- Milk-V Pioneer Box (v1.3) oERV 23.09 / ruyi 0.4.0 版本测试报告 [PR](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/8)
- AllWinner D1 / Lichee RV & StarFive VisionFive 镜像刷写测试报告 [PR](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/10)
- D1 (Lichee RV & AWOL Nezha) 镜像刷写测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240130/D1-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)
- StarFive VisionFive 镜像刷写测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240130/VisionFive-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)
- ruyi rpm 打包版本 / openEuler RISC-V 测试 [log](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month10/ruyi_oERV_test.log)
    - 环境：openEuler 23.09 preview rootfs on systemd-nspawn, QEMU 8.2.0

#### v0.5.0

- Milk-V Pioneer Box (v1.3) oERV 23.09 / ruyi 0.4.0 版本测试报告 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240224/oERV2309-SG2042-Pioneer.md)
- HiFive Unmatched 镜像刷写报告（openEuler + OpenWrt）[Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240224/HiFive_Unmatched-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)

#### mugen 自动化测试

- 修复 `ruyi_test_gnu-plct-rv64ilp32-elf` 意外失败/未能正常创建源码文件的问题 [commit](https://github.com/weilinfox/ruyi-mugen/commit/d7fa8153e47ea7db475206f9559398ebd2764c16)

## 其他内容

- 荔枝派 4A / LPi4A 开启 WiFi 热点 / AP [文档](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month10/LPi4A_AP.md)
    - preview 版本镜像 `firewalld` 无法启动，经确认，最新 devel 版镜像已修复