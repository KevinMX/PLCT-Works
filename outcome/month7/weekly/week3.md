## week 3

2023.11.20 ~ 2023.11.24

### 本周工作

- openEuler 23.09 RISC-V on Lichee Pi 4A 测试。
    - 发现缺陷数个，见下表。
    - 测试新的镜像刷写流程：`fastboot flash ram -> reboot -> flash uboot -> flash boot -> flash root -> power reset`
    - 安装 Xfce 目前需要手动添加 `tarsier-infra` 软件源。
    - 连接 WiFi 需要先连接有线网络并安装 `NetworkManager-wifi`
- 测试 OpenJDK on openEuler RISC-V on Docker。
- 测试 [Firefox 115 ESR](http://124.70.71.209:82/openEuler:/23.09:/RISC-V:/Jingwiw/standard_riscv64/riscv64/) on openEuler RISC-V on Lichee Pi 4A & QEMU。
    - 软件包依赖错误：`redhat-indexhtml` -> `openEuler-indexhtml`
    - 软件包文件冲突：`libnss3.so` 同时被 `nss-3.94-1` 和 `firefox-115.5.0-1` 提供（已修复）
    - 切换标签页后网页会卡在转圈圈（加载）
    - `ffmpeg` 禁用时 `H264` 软解不工作
    - `ffmpeg` 启用时 `H264` 软解只能播放一段时间，然后视频卡死
    - 硬件编解码目前不工作
- QtRVSim 测试工作：
    - quickstart [PR](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/3)
    - GUI [PR](https://gitee.com/yunxiangluo/qtrvsim-test/pulls/9)
- 技术分享：QtRVSim GUI

#### 缺陷报告 / Issues

| ID/Link                                                    | 缺陷名称                                                                       |
|------------------------------------------------------------|----------------------------------------------------------------------------|
| [I8J7XE](https://gitee.com/openeuler/RISC-V/issues/I8J7XE) | openEuler 23.09 RISC-V Lichee Pi 4A testing 镜像默认未安装 NetworkManager-wifi |
| [I8IFPN](https://gitee.com/openeuler/RISC-V/issues/I8IFPN) | 23.03 Lichee Pi 4A 在 Docker 内运行 Java 17/19 时崩溃                          |