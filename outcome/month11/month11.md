# Month 10

记录本月产出。

## RuyiSDK

### 调研 / 操作系统支持矩阵

对市面上主流 RISC-V 开发板进行调研，编写所有可用操作系统的刷写&测试报告。

提供了各开发板目前已经提供了可用系统镜像的系统测试报告，其中包含启动日志/屏幕录像。

目前已覆盖 13 款开发板、20 余种操作系统：

| CPU      | 产品型号                      | Arch Linux | Debian/RevyOS | Fedora | FreeBSD | Gentoo | openAnolis | OpenBSD | openCloudOS | openEuler | openKylin | openSUSE | Ubuntu | Tina-Linux | Android 13 | Armbian | BuildRoot | OpenHarmony | FreeRTOS | RT-Thread | Zephyr | OpenWRT | ThreadX |
|----------|-------------------------------|------------|---------------|--------|---------|--------|------------|---------|-------------|-----------|-----------|----------|--------|------------|------------|---------|-----------|-------------|----------|-----------|--------|---------|---------|
| SG2042   | [Pioneer Box][Pioneer]        | N/A        | Good          | Good   | N/A     | N/A    | N/A        | N/A     | WIP         | Good      | Good      | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | WIP         | N/A      | N/A       | N/A    | N/A     | N/A     |
| CV1800B  | [Milk-V Duo (64M)][Duo]       | Basic      | Basic         | CFH    | N/A     | N/A    | N/A        | N/A     | N/A         | Basic     | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | Basic    | Basic     | N/A    | WIP     | N/A     |
| TH1520   | [LicheePi 4A][LPi4A]          | Good       | Good          | Good   | N/A     | N/A    | N/A        | N/A     | N/A         | Good      | Good      | N/A      | WIP    | N/A        | N/A        | Good    | N/A       | WIP         | N/A      | N/A       | N/A    | Basic   | N/A     |
| JH7100   | [VisionFive][VF1]             | N/A        | N/A           | Good   | N/A     | N/A    | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | N/A        | Basic   | Basic     | N/A         | N/A      | N/A       | N/A    | Basic   | N/A     |
| JH7110   | [VisionFive 2][VF2]           | Basic      | Good          | N/A    | WIP     | Basic  | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | WIP        | Good    | Basic     | WIP         | N/A      | Basic     | CFH    | Basic   | N/A     |
| K230     | [CanMV K230][K230]            | N/A        | Basic         | Basic  | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | Basic  | N/A        | N/A        | N/A     | N/A       | N/A         | N/A      | Basic     | N/A    | N/A     | N/A     |
| C906     | [LicheeRV/AWOL Nezha][C906]   | N/A        | Good          | Good   | WIP     | N/A    | N/A        | N/A     | N/A         | Good      | N/A       | Basic    | Basic  | Basic      | N/A        | N/A     | N/A       | N/A         | N/A      | N/A       | N/A    | Basic   | N/A     |
| U740     | [HiFive Unmatched][Unmatched] | N/A        | Basic         | Good   | Basic   | N/A    | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | N/A        | CFH     | N/A       | WIP         | N/A      | N/A       | Basic  | Basic   | N/A     |
| SG2000   | [Milk-V Duo S][DuoS]          | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| JH7110   | [Milk-V Mars][Mars]           | N/A        | CFT           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | CFT       | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| FSL1030M | [Milk-V Vega][Vega]           | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | CFH       | N/A         | N/A      | N/A       | N/A    | N/A     | N/A     |
| TH1520   | [Milk-V Meles][Meles]         | N/A        | CFT           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | N/A         | N/A      | N/A       | N/A    | N/A     | N/A     |

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

[Pioneer]: https://github.com/ruyisdk/support-matrix/blob/main/Pioneer/README.md
[Duo]: https://github.com/ruyisdk/support-matrix/blob/main/Duo/README.md
[LPi4A]: https://github.com/ruyisdk/support-matrix/blob/main/LicheePi4A/README.md
[VF1]: https://github.com/ruyisdk/support-matrix/blob/main/VisionFive/README.md
[VF2]: https://github.com/ruyisdk/support-matrix/blob/main/VisionFive2/README.md
[K230]: https://github.com/ruyisdk/support-matrix/blob/main/K230/README.md
[C906]: https://github.com/ruyisdk/support-matrix/blob/main/D1_LicheeRV/README.md
[Unmatched]: https://github.com/ruyisdk/support-matrix/blob/main/Unmatched/README.md
[DuoS]: https://github.com/ruyisdk/support-matrix/blob/main/Duo_S/README.md
[Mars]: https://github.com/ruyisdk/support-matrix/blob/main/Mars/README.md
[Vega]: https://github.com/ruyisdk/support-matrix/blob/main/Vega/README.md
[Meles]: https://github.com/ruyisdk/support-matrix/blob/main/Meles/README.md