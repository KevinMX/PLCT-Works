# month 22

记录本月产出。

## J129 / 丁丑小队 / 操作系统支持矩阵

- PR Review
    - [Add a new RTOS: LiteOS and add LiteOS test report for CH32V307](https://github.com/ruyisdk/support-matrix/pull/175)
    - [BIT-BRICK K1:add new board  ](https://github.com/ruyisdk/support-matrix/pull/176)
    - [LicheePi4A: update to fedora 41](https://github.com/ruyisdk/support-matrix/pull/178)
    - [BPI-F3: Update Bianbu v2.0.4 to v2.1](https://github.com/ruyisdk/support-matrix/pull/179)
    - [feat/tools: split customized linux distributions](https://github.com/ruyisdk/support-matrix/pull/180)
    - [LicheePi4A/RevyOS: Remove ruyi-install version](https://github.com/ruyisdk/support-matrix/pull/181)
    - [VisionFive2: add eweOS,update openkylin 2.0 SP1](https://github.com/ruyisdk/support-matrix/pull/182)
    - [feat/tools: remove customized distributions from linux table](https://github.com/ruyisdk/support-matrix/pull/183)
    - [Pioneer: Bump a bunch of reports](https://github.com/ruyisdk/support-matrix/pull/184)
    - [LicheeRV & Duo & Duo256m & VisionFive2/nixos: fix typo](https://github.com/ruyisdk/support-matrix/pull/185)
    - [Fix: make `sys` field case insensitive](https://github.com/ruyisdk/support-matrix/pull/186)
    - [Add LiteOS test report for CH32V208, update documents and fix some typos.](https://github.com/ruyisdk/support-matrix/pull/187)
    - [Add/Update mangopi_mq_pro (1)](https://github.com/ruyisdk/support-matrix/pull/188)
    - [  update Licheepi4A_RevyOS_20250123](https://github.com/ruyisdk/support-matrix/pull/189)
    - [ IndexUpdator: V1 Version](https://github.com/ruyisdk/support-matrix/pull/190)
    - [fix: images generation](https://github.com/ruyisdk/support-matrix/pull/191)
    - [VisionFive2: add irradium(core),Bit-Brick_K1: update bianbu](https://github.com/ruyisdk/support-matrix/pull/192)
    - [CONTRIBUTING: Add CONTRIBUTING.md and report-templates](https://github.com/ruyisdk/support-matrix/pull/193)
    - [Bit-Brick_K1: add armbian (minimal)](https://github.com/ruyisdk/support-matrix/pull/194)
    - [VisionFive2: remove non-existent images](https://github.com/ruyisdk/support-matrix/pull/196)
    - [Update mangopi_mq_pro and dongshanpi_stu](https://github.com/ruyisdk/support-matrix/pull/197)
    - [LicheeRV_Dock: rename and add irradium](https://github.com/ruyisdk/support-matrix/pull/198)
    - [VisionFive2: update debian to 202409](https://github.com/ruyisdk/support-matrix/pull/199)
    - [Add/Update mangopi_mq_pro / dongshanpistu (2) ](https://github.com/ruyisdk/support-matrix/pull/200)
    - [Add Ubuntu testing reports for MilkV DuoS](https://github.com/ruyisdk/support-matrix/pull/201)
    - [Fix: broken Zephyr link](https://github.com/ruyisdk/support-matrix/pull/202)
    - [Add Mars Deepin 25 test reports and Ubuntu LTS reports.](https://github.com/ruyisdk/support-matrix/pull/203)
    - [DuoS: Add OpenWrt test report](https://github.com/ruyisdk/support-matrix/pull/204)
    - [ci: fix CFI](https://github.com/ruyisdk/support-matrix/pull/205)
    - [sort metadata,move buildroot and yocto to customized linux](https://github.com/ruyisdk/support-matrix/pull/206)
    - [Fix: make key also case-insensitive](https://github.com/ruyisdk/support-matrix/pull/207)
    - [LicheePi4A/Armbian: fix typo](https://github.com/ruyisdk/support-matrix/pull/208)
    - [BPI-F3/openHarmony: Add v5.0.0.71](https://github.com/ruyisdk/support-matrix/pull/209)
    - [Bit-Brick_K1: add fedora 42 minimal](https://github.com/ruyisdk/support-matrix/pull/211)
- New
    - [ci: fix CFI](https://github.com/ruyisdk/support-matrix/pull/205)
- J129 实习生/新人面试

### RuyiSDK 双周报/支持矩阵部分

- https://github.com/ruyisdk/wechat-articles/pull/132
- https://github.com/ruyisdk/wechat-articles/pull/136

### 独立测试项目/应用软件生态观测

N/A

## J143 / RevyOS 小队

（仅包括可公开部分。）

- 测试 Milk-V Meles 修了 `cpufreq` 问题的新 dtb / 内核
- 重新过了一遍所有 TH1520 相关 issue，新内核复测了一部分，回了一些有更新/已经修了的
    - 回复：
        - [20241229 Meles 音频输出口无声音](https://github.com/revyos/revyos/issues/100)
    - Closed as completed: 
        - [licheepi 4a 无法打开默认浏览器](https://github.com/revyos/revyos/issues/82)
        - [meles的htop CPU信息显示offline，需要修复](https://github.com/revyos/revyos/issues/109)
    - 新 issue：
        - [\[Package Upgrade\] firefox and firefox-esr](https://github.com/revyos/revyos/issues/116)
- J143 实习生/新人面试
- RISC-V Open Hours [Slide](https://docs.google.com/presentation/d/1RK-SQyoH2kxuuYYkH1KMRhmLgyNMCvdNFDv4l5uTXZQ)
- RISC-V 东亚时区双周会 [Slide](https://docs.google.com/presentation/d/1OxshenCoHIg993UPomizsJ5QghhFRVz1P_i1bf1xiQ8/edit?usp=sharing)
- Issue 跟进
    - 非常规分辨率问题：https://github.com/revyos/revyos/issues/117
    - Meles Wi-Fi 天线问题（已提供临时解决方案）：https://github.com/revyos/revyos/issues/118
- 新 CI 镜像测试
- Milk-V Pioneer 6.14 内核新镜像及测试，RuyiSDK Office Hours 首发

## 其他内容

- 内部 Infra 日常维护
    - 电源更换
    - 上架 K230，为 https://github.com/ruyisdk/ruyisdk/issues/2 做准备
    - https://radiata.kevinmx.top   
- 其它线下事务处理