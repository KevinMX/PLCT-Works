## week 4

2023.11.27 ~ 2023.12.01

### 本周工作

openEuler 23.09 独立发版测试：

- Firefox & nmtui [测试用例](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/3)
- HiFive Unmatched [安装文档](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/blob/master/Unmatched/Installation_Handbook.md)
- VisionFive [安装文档](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/blob/master/VisionFive/Installation_Handbook.md)
- VisionFive 2 [安装文档](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/blob/master/VisionFive2/Installation_Handbook.md)
- LPi4A [安装文档更新](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/blob/master/lpi4a/Install.md)
- D1 Nezha & LicheeRV 测试启动镜像
    - 目前状况：bootloop
- 协助测试 VisionFive 2 无法启动的问题
- 协助排查 VisionFive 2 启动 Firefox 时死机重启的问题（经排查为 SoC 未加散热片过热导致）
- 协助测试 Firefox 115 ESR
    - 经测试目前可在 QEMU / LPi4A / VisionFive / VisionFive 2 启动
    - 先前出现的 H264 解码问题已解决
