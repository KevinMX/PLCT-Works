# month 9

记录本月产出。

## RuyiSDK

- RuyiSDK IDE 调研工作：[基于 VSCode，尝试走通 RISC-V 架构 C 的编译、调试流程](https://github.com/ruyisdk/pmd/issues/5) -> 文档见 [此处](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month9/vscode.md)
- RuyiSDK / 开发板操作系统支持情况调研
    - BeagleV Fire
    - ESP32C3 LUATOS CORE
    - SiFive HiFive 1
    - SiFive HiFive 1 Rev B

### RuyiSDK 测试

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

#### 缺陷列表

| Issue                                                                                                       | 详细信息                                                |
|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| [RISC-V 开发板系统镜像安装工具，增加 4 款 RISC-V 开发板](https://github.com/ruyisdk/ruyi/issues/41)          | 确定 D1 两款开发板硬件 & DTB 情况：硬件略有不同，系统已兼容两种开发板，建议手动修改 GRUB 启动项 |
| [Device provision: warn users about adding udev rules for LPi4A](https://github.com/ruyisdk/ruyi/issues/39) | fastboot 需要特权或配置 udev 规则，已修复                |

## openEuler RISC-V

- oERV 24.03 测试调研工作
    - mmtest on SG2042 测试/摸底工作
        - SG2042 上能跑通，但出现了计划外的硬件问题（PCI-E Switch 风扇故障），更换了桥片风扇后继续进行测试
        - 测试 log 见 [mmtests](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month9/mmtests/)
        - 结果分析见：[week1](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/outcome/month9/weekly/week1.md)
        - mmtest 会拉起 LTP 进行测试，有重叠部分
        - 安装脚本更新：[commit](https://gitee.com/KevinMX/ltpstress-for-openeuler/commit/49135c9c02a2f8bfd2af28ae3756d9d8d4e56234)
    - 测试策略更新：[PR](https://gitee.com/yunxiangluo/openEuler-RISCV-2403LTS-Pretest/pulls/2)
    - 测试结果分析
        - LPi4A: LTP [oERV](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month8/2309-hw-pre_mainline/LTP/LPi4A/)
        - Pioneer: LTP [oERV](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month8/2309-hw-pre_mainline/LTP/Pioneer_v1p3/result_analysis.csv) / [RevyOS](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month8/RevyOS_20231220_Pioneer_v1p3/result-analysis.csv)
- 修包工作：iozone spec 添加 riscv64 支持 [!PR](https://gitee.com/src-openeuler/iozone/pulls/7) （已合入）
- 调查 oERV perf top SIGSEGV 问题，并提交 core dump 结果：[I8TLYZ](https://gitee.com/openeuler/RISC-V/issues/I8TLYZ?from=project-issue#note_24150341_link)

## 其他工作

- 山大 SG2042 服务器网络接入
    - 搭建 Tailscale DERP 中继节点，优化国内连接延迟
    - 尝试解决 Share out machine 无法使用自建 DERP 节点的问题
    - 记录 [文档](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month9/tailscale.md)
- 技术报告：[开源自动化测试工具 openQA 在 openEuler RISC-V 测试中的使用](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/reports/month9/开源自动化测试工具openQA在openEuler%20RISC-V测试中的使用.pdf)
- SG2042 / Milk-V Pioneer InferGLM / ChatGLM 测试
    - InferLLM 带 Vector 加速
    - ChatGLM.cpp 不带 Vector 加速
    - 产出文档 [InferLLM](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month9/InferLLM/README.md)