# Week 0 / 本周工作

## RuyiSDK

### 调研

[操作系统支持矩阵](https://github.com/KevinMX/support-matrix) ：开发板系统测试报告编写

#### 已完成测试的部分

| CPU      | 产品型号                       | Arch Linux | Debian/RevyOS | Fedora | FreeBSD | Gentoo | openAnolis | OpenBSD | openCloudOS | openEuler | openKylin | openSUSE | Ubuntu | Tina-Linux | Android 13 | Armbian | BuildRoot | OpenHarmony | FreeRTOS | RT-Thread | Zephyr | OpenWRT | ThreadX |
|----------|--------------------------------|------------|---------------|--------|---------|--------|------------|---------|-------------|-----------|-----------|----------|--------|------------|------------|---------|-----------|-------------|----------|-----------|--------|---------|---------|
| SG2042   | [Pioneer Box][Pioneer]         | N/A        | Good          | Good   | N/A     | N/A    | N/A        | N/A     | WIP         | Good      | Good      | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | WIP         | N/A      | N/A       | N/A    | N/A     | N/A     |
| CV1800B  | [Milk-V Duo (64M)][Duo]        | Basic      | Basic         | CFH    | N/A     | N/A    | N/A        | N/A     | N/A         | Basic     | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | Basic    | Basic     | N/A    | WIP     | N/A     |
| TH1520   | [LicheePi 4A][LPi4A]           | Good       | Good          | Good   | N/A     | N/A    | N/A        | N/A     | N/A         | Good      | Good      | N/A      | WIP    | N/A        | N/A        | Good    | N/A       | WIP         | N/A      | N/A       | N/A    | Basic   | N/A     |
| JH7100   | [VisionFive][VF1]              | N/A        | N/A           | Good   | N/A     | N/A    | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | N/A        | Basic   | Basic     | N/A         | N/A      | N/A       | N/A    | Basic   | N/A     |
| JH7110   | [VisionFive 2][VF2]            | Basic      | Good          | N/A    | WIP     | Basic  | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | WIP        | Good    | Basic     | WIP         | N/A      | Basic     | CFH    | Basic   | N/A     |
| K230     | [CanMV K230][K230]             | N/A        | Basic         | Basic  | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | Basic  | N/A        | N/A        | N/A     | N/A       | N/A         | N/A      | Basic     | N/A    | N/A     | N/A     |
| C906     | [LicheeRV/AWOL Nezha][C906]    | N/A        | Good          | Good   | WIP     | N/A    | N/A        | N/A     | N/A         | Good      | N/A       | Basic    | Basic  | Basic      | N/A        | N/A     | N/A       | N/A         | N/A      | N/A       | N/A    | Basic   | N/A     |
| U740     | [HiFive Unmatched][Unmatched]  | N/A        | Basic         | Good   | Basic   | N/A    | N/A        | Basic   | N/A         | Good      | Good      | Basic    | Basic  | N/A        | N/A        | CFH     | N/A       | WIP         | N/A      | N/A       | Basic  | Basic   | N/A     |
| SG2000   | [Milk-V Duo S][DuoS]           | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | Basic     | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| JH7110   | [Milk-V Mars][Mars]            | N/A        | CFT           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | CFT       | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| FSL1030M | [Milk-V Vega][Vega]            | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | CFH       | N/A         | N/A      | N/A       | N/A    | N/A     | N/A     |
| TH1520   | [Milk-V Meles][Meles]          | N/A        | CFT           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | N/A         | N/A      | N/A       | N/A    | N/A     | N/A     |
| K210     | [Sipeed Maix-I][Maix]          | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
| TH1520   | [Lichee Cluster 4A][Cluster4A] | N/A        | Good          | Good   | N/A     | N/A    | N/A        | N/A     | N/A         | Good      | Good      | N/A      | N/A    | N/A        | N/A        | Good    | N/A       | N/A         | N/A      | N/A       | N/A    | Basic    | N/A     |
| TH1520   | [Lichee Console 4A][Console4A] | N/A        | CFT           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | N/A       | N/A         | N/A      | N/A       | N/A    | N/A     | N/A     |
| SG2002   | [LicheeRV Nano][LicheeRVNano]  | N/A        | N/A           | N/A    | N/A     | N/A    | N/A        | N/A     | N/A         | N/A       | N/A       | N/A      | N/A    | N/A        | N/A        | N/A     | CFT       | N/A         | CFT      | N/A       | N/A    | N/A     | N/A     |
#### 说明

* Good：支持图形界面
* Basic：能启动运行
* CFH (Call for help)：官方/论坛资料表示支持，但是未跑通
* CFT (Call for testing)：镜像链接有，但是缺乏硬件设备验证
* CFI (Call for more information)：官方资料宣称有，但是找不到镜像文件等实际可用的资料
* WIP：官方宣发操作系统即将/正在对开发板进行支持，但暂未获取到可用的镜像
* N/A：暂未从官方或者其它渠道获取到开发板的支持信息

[Pioneer]:  https://github.com/ruyisdk/support-matrix/blob/main/Pioneer/README.md
[Duo]:  https://github.com/ruyisdk/support-matrix/blob/main/Duo/README.md
[LPi4A]:  https://github.com/ruyisdk/support-matrix/blob/main/LicheePi4A/README.md
[VF1]:  https://github.com/ruyisdk/support-matrix/blob/main/VisionFive/README.md
[VF2]:  https://github.com/ruyisdk/support-matrix/blob/main/VisionFive2/README.md
[K230]:  https://github.com/ruyisdk/support-matrix/blob/main/K230/README.md
[C906]:  https://github.com/ruyisdk/support-matrix/blob/main/D1_LicheeRV/README.md
[Unmatched]:  https://github.com/ruyisdk/support-matrix/blob/main/Unmatched/README.md
[DuoS]:  https://github.com/ruyisdk/support-matrix/blob/main/Duo_S/README.md
[Mars]:  https://github.com/ruyisdk/support-matrix/blob/main/Mars/README.md
[Vega]:  https://github.com/ruyisdk/support-matrix/blob/main/Vega/README.md
[Meles]:  https://github.com/ruyisdk/support-matrix/blob/main/Meles/README.md
[Maix]:  https://github.com/ruyisdk/support-matrix/blob/main/Maix-I_K210/README.md
[Cluster4A]:  https://github.com/ruyisdk/support-matrix/blob/main/LicheeCluster4A/README.md
[Console4A]:  https://github.com/ruyisdk/support-matrix/blob/main/LicheeConsole4A/README.md
[LicheeRVNano]:  https://github.com/ruyisdk/support-matrix/blob/main/LicheeRV_Nano/README.md

新增：

- Maix-I (K210)
    - FreeRTOS
- LicheeRV Nano
    - FreeRTOS
    - BuildRoot
- Lichee Console 4A
    - RevyOS
- Lichee Cluster 4A
    - RevyOS


审核实习生提交的 PR：

- [Lichee Cluster 4A](https://github.com/ruyisdk/support-matrix/pull/12)
- [VisionFive 2](https://github.com/ruyisdk/support-matrix/pull/10)
    - Zephyr
    - RT-Thread
- [K230](https://github.com/ruyisdk/support-matrix/pull/10)
    - RT-Thread

更新 [mugen_ruyi](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/scripts/mugen_ruyi.sh) 测试脚本

- 切换至非特权用户执行测试