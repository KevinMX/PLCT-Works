# Week 3 / 本周工作

## RuyiSDK

### 调研

[操作系统支持矩阵](https://github.com/KevinMX/support-matrix) ：开发板系统测试报告编写

#### 已完成测试的部分

| CPU      | 产品型号                      | Arch Linux | Debian/RevyOS | Fedora | FreeBSD | Gentoo | openAnolis | OpenBSD | openCloudOS | openEuler | openKylin | openSUSE | Ubuntu | Tina-Linux | Android 13 | Armbian | BuildRoot | OpenHarmony | FreeRTOS | RT-Thread | Zephyr | OpenWRT | ThreadX |
|----------|-------------------------------|------------|---------------|--------|---------|--------|------------|---------|-------------|-----------|-----------|----------|--------|------------|------------|---------|-----------|-------------|----------|-----------|--------|---------|---------|
| SG2042   | [Pioneer Box][Pioneer]        | CFT        | Good          | Good   | N/A     | N/A    | N/A        | N/A     | WIP         | Good      | Good      | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | WIP         | N/A      | N/A       | N/A    | N/A     | N/A     |
| CV1800B  | [Milk-V Duo (64M)][Duo]       | CFT        | CFT           | CFT    | N/A     | N/A    | N/A        | N/A     | N/A         | CFT       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | CFT      | CFT       | N/A    | WIP     | N/A     |
| TH1520   | [LicheePi 4A][LPi4A]          | Good       | Good          | Good   | N/A     | CFT    | N/A        | N/A     | N/A         | Good      | Good      | N/A      | WIP    | N/A        | N/A        | Good    | N/A       | WIP         | N/A      | N/A       | N/A    | CFT     | N/A     |
| JH7100   | [VisionFive][VF1]             | CFT        | CFT           | Good   | N/A     | CFT    | N/A        | CFT     | N/A         | Good      | Good      | Basic    | Basic  | N/A        | N/A        | CFT     | CFT       | N/A         | CFT      | N/A       | N/A    | CFT     | N/A     |
| JH7110   | [VisionFive 2][VF2]           | CFT        | Good          | CFT    | CFT     | CFT    | N/A        | N/A     | N/A         | Good      | Good      | CFT      | Basic  | N/A        | WIP        | CFT     | Basic     | WIP         | N/A      | CFT       | CFT    | CFT     | N/A     |
| K230     | [CanMV K230][K230]            | CFT        | Basic         | Basic  | N/A     | CFT    | N/A        | N/A     | N/A         | CFT       | N/A       | N/A      | Basic  | N/A        | N/A        | N/A     | N/A       | N/A         | N/A      | CFT       | N/A    | CFT     | N/A     |
| C906     | [LicheeRV/AWOL Nezha][C906]   | CFT        | Good          | Good   | WIP     | CFT    | N/A        | N/A     | N/A         | Good      | N/A       | Basic    | Basic  | Basic      | N/A        | N/A     | N/A       | N/A         | N/A      | N/A       | N/A    | Basic   | N/A     |
| U740     | [HiFive Unmatched][Unmatched] | CFT        | Basic         | CFT    | Basic   | CFT    | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | N/A        | CFH     | N/A       | WIP         | N/A      | N/A       | Basic  | Basic   | N/A     |
| SG2000   | [Milk-V Duo S][DuoS]          | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| JH7110   | [Milk-V Mars][Mars]           | N/A        | CFT           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| FSL1030M | Milk-V Vega          | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | CFH       | N/A         | N/A      | N/A       | N/A    | N/A     | N/A     |

新增：
- VisionFive 2
    - BuildRoot
    - Ubuntu 23.10
    - openKylin 1.0.1
- Milk-V Duo S
- Milk-V Mars
- Milk-V Vega
- HiFive Unmatched
    - openSUSE Tumbleweed (JeOS)

审核实习生提交的 PR：

https://github.com/KevinMX/support-matrix/pull/1
https://github.com/KevinMX/support-matrix/pull/2

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