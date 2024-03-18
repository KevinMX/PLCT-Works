# Week 2 / 本周工作

## RuyiSDK

### ruyi 包管理器

- Milk-V Pioneer / openEuler 23.09 RISC-V [测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/23)
- HiFive Unmatched [新增镜像刷写测试报告](https://gitee.com/yunxiangluo/ruyisdk-test/pulls/20)

### 调研

[操作系统支持矩阵](https://github.com/KevinMX/support-matrix/tree/boards) ：开发板系统测试（三级页面）报告编写，确定模板/格式

#### 已完成测试的部分

- HiFive Unmatched
    - Debian
    - FreeBSD
    - OpenBSD
    - openEuler
    - openKylin
    - OpenWrt
    - Ubuntu
    - Zephyr
- AWOL Nezha D1 / Sipeed Lichee RV Dock D1
    - openEuler
    - OpenWrt
    - TinaLinux
    - Ubuntu
- Lichee Pi 4A (16GB + 128GB)
    - openEuler
    - RevyOS
- Milk-V Duo (64M, CV1800B)
    - BuildRoot
- Milk-V Pioneer
    - openEuler
- CanMV K230
    - Debian
    - Ubuntu
- StarFive VisionFive 2
    - openEuler

## 其他内容

### Eulaceura 23H2 RISC-V 测试 / 缺陷报告

| Issue ID                                                    | 详情                                      | 状态 |
|-------------------------------------------------------------|-----------------------------------------|------|
| [I98ZPO](https://gitee.com/eulaceura/Tracker/issues/I98ZPO) | 23H2 LPi4A Desktop rootfs 不会自动 resize | TBD  |