## week 2

2024.01.15 ~ 2024.01.19

### 本周工作

#### RuyiSDK 测试

LPi4A：

- openEuler
    - mugen 自动化测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/oERV2309-LPi4A.md)
    - 镜像刷写测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/LPi4A-Pioneer-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)

Milk-V Pioneer / SG2042
- openEuler
    - mugen 自动化测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/oERV2309-SG2042-Pioneer.md)
    - 镜像刷写测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240116/LPi4A-Pioneer-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)
- Fedora
    - mugen 自动化测试 [Gitee](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/4)

Milk-V Duo
- buildroot
    - 镜像刷写测试 [屏幕录像](https://asciinema.org/a/rsenSOJwdlmUXcJ8sQwubPgtr?autoplay=1)

更新刷写文档：[commit](https://gitee.com/KevinMX/ruyisdk-test/commit/3a3c8798a4e24a148cb3efb804347f6b60f55230)

##### 缺陷列表

| Issue                                                                                                       | 详细信息                                                |
|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| [RISC-V 开发板系统镜像安装工具，增加 4 款 RISC-V 开发板](https://github.com/ruyisdk/ruyi/issues/41)          | 确定 D1 两款开发板硬件 & DTB 情况：硬件略有不同，系统已兼容两种开发板，建议手动修改 GRUB 启动项 |
| [Device provision: warn users about adding udev rules for LPi4A](https://github.com/ruyisdk/ruyi/issues/39) | fastboot 需要特权或配置 udev 规则，已修复                |