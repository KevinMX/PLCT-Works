# month 7

记录本月产出。

- 修正 [自动化测试脚本](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/scripts)。
- 协助 openEuler 23.09 RISC-V 独立发行版镜像测试（烧写镜像检查是否能够正常启动）。
- 编写 Node.js [测试报告](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month7/node/report_oe2309)。
- 参加 SIG-QA 会议 & openEuler 社区优秀贡献者评选。- [etherpad](https://etherpad.openeuler.org/p/sig-QA-meetings)
- 测试 OpenJDK on openEuler RISC-V on Docker。- Issue [I8IFPN](https://gitee.com/openeuler/RISC-V/issues/I8IFPN)
- 调研 LTP 下一代测试执行器 Kirk（先前为 runltp-ng） - [Kirk](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/reports/month7/oERV专项测试拾遗：次世代LTP执行器Kirk)
- 调研 RISC-V SAIL / ACT。
- 准备 RuyiSDK 测试。
    - `ruyi update` 在未预装 git 的系统上无法运行（已修复）
- QtRVSim 测试工作：
    - quickstart [PR](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/3)
    - GUI [PR](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/9)
- 技术分享：QtRVSim GUI
openEuler 23.09 独立发版测试
- Firefox & nmtui [测试用例](https://gitee.com/yunxiangluo/openEuler-RISC-V-23.09-independent/pulls/3)
- HiFive Unmatched
    - [安装文档](https://gitee.com/KevinMX/openEuler-RISC-V-23.09-independent/blob/master/Unmatched/Installation_Handbook.md)
- VisionFive
    - [安装文档](https://gitee.com/KevinMX/openEuler-RISC-V-23.09-independent/blob/master/VisionFive/Installation_Handbook.md)
- VisionFive 2
    - [安装文档](https://gitee.com/KevinMX/openEuler-RISC-V-23.09-independent/blob/master/VisionFive2/Installation_Handbook.md)
    - 协助测试 VisionFive 2 无法启动的问题（已解决）
    - 协助排查 VisionFive 2 启动 Firefox 时死机重启的问题（经排查为 SoC 未加散热片过热导致）
- Lichee Pi 4A
    - [安装文档更新](https://gitee.com/KevinMX/openEuler-RISC-V-23.09-independent/blob/master/lpi4a/Install.md)
    - 测试新的镜像刷写流程：`fastboot flash ram -> reboot -> flash uboot -> flash boot -> flash root -> power reset`
    - 连接 WiFi 需要先连接有线网络并安装 `NetworkManager-wifi`（已解决）
    - 安装 Xfce 目前需要手动添加 `tarsier-infra` 软件源（已解决：默认已提供 Xfce 镜像，preview 版无此问题）
- D1 Nezha & LicheeRV 测试启动镜像
    - 目前状况：bootloop
- 协助测试 Firefox 115 ESR
    - 软件包依赖错误：`redhat-indexhtml` -> `openEuler-indexhtml` （已修复）
    - 软件包文件冲突：`libnss3.so` 同时被 `nss-3.94-1` 和 `firefox-115.5.0-1` 提供（已修复）
    - 切换标签页后网页会卡在转圈圈（加载）（已修复）
    - `ffmpeg` 禁用时 `H264` 软解不工作（已修复）
    - `ffmpeg` 启用时 `H264` 软解只能播放一段时间，然后视频卡死（已修复）
    - 硬件编解码目前不工作
    - 经测试目前可在 QEMU / LPi4A / VisionFive / VisionFive 2 启动

#### 缺陷报告 / Issues

| ID/Link                                                    | 缺陷名称                                                                       | 状态          |
|------------------------------------------------------------|----------------------------------------------------------------------------|---------------|
| [I8J7XE](https://gitee.com/openeuler/RISC-V/issues/I8J7XE) | openEuler 23.09 RISC-V Lichee Pi 4A testing 镜像默认未安装 NetworkManager-wifi | Closed, fixed |
| [I8IFPN](https://gitee.com/openeuler/RISC-V/issues/I8IFPN) | 23.03 Lichee Pi 4A 在 Docker 内运行 Java 17/19 时崩溃                          | Open          |
| [#11](https://github.com/ruyisdk/ruyi/issues/11)           | ruyi update 在未预装 git 的系统上无法运行                                      | Closed, fixed |