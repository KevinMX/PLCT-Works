# Month 10

记录本月产出。

## RuyiSDK

### 调研 / 操作系统支持矩阵

对市面上主流 RISC-V 开发板进行调研，编写所有可用操作系统的刷写&测试报告。

提供了各开发板目前已经提供了可用系统镜像的系统测试报告，其中包含启动日志/屏幕录像。

目前已覆盖 13 款开发板、20 余种操作系统：

Milk-V: Duo / Duo S / Mars / Meles / Pioneer / Vega

StarFive: VisionFive / VisionFive 2

Sipeed: LicheePi 4A / Lichee RV D1

CanMV: K230

SiFive: HiFive Unmatched

AWOL: Nezha D1

详情见：https://github.com/ruyisdk/support-matrix

### PR Review

https://github.com/KevinMX/support-matrix/pull/1
https://github.com/KevinMX/support-matrix/pull/2
https://github.com/KevinMX/support-matrix/pull/3
https://github.com/KevinMX/support-matrix/pull/4

### RuyiSDK 测试

#### ruyi 包管理器 v0.6

- [openEuler RISC-V 23.03 / Milk-V Pioneer](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240312/oERV2309-SG2042-Pioneer.md)
- HiFive Unmatched 镜像刷写测试：[openKylin & Ubuntu](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240312/HiFive_Unmatched-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)

#### ruyi 包管理器 v0.7

- HiFive Unmatched 镜像刷写测试：[OpenBSD & FreeBSD Live Installer](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240327/HiFive_Unmatched-%E9%95%9C%E5%83%8F%E5%88%B7%E5%86%99%E6%B5%8B%E8%AF%95.md)
- [openEuler RISC-V 23.09 on Lichee Pi 4A](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240327/oERV2309-lpi4a.md)
- [openEuler RISC-V 23.09 on Milk-V Pioneer / SG2042](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240327/oERV2309-SG2042-Pioneer.md)
- [Debian bookworm/sid（厂商镜像）on StarFive VisionFive 2](https://gitee.com/yunxiangluo/ruyisdk-test/blob/master/20240327/debian-visionfive2.md)


#### mugen 自动化测试

- [mugen_ruyi 自动化测试脚本](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/scripts/mugen_ruyi.sh)

## 其他内容

### Eulaceura 23H2 RISC-V 测试 / 缺陷报告

| Issue ID                                                    | 详情                                      | 状态 |
|-------------------------------------------------------------|-----------------------------------------|------|
| [I98ZPO](https://gitee.com/eulaceura/Tracker/issues/I98ZPO) | 23H2 LPi4A Desktop rootfs 不会自动 resize | TBD  |