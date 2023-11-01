# month 6

记录本月产出。

- 补充 openEuler 23.09 RISC-V RC4 测试报告/LTP Long Stress [PR !72](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/72)
- 在 openEuler 23.09 RISC-V RC5 上执行 Round 5 测试。[Round5](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/Round5/BasicTest)
- 分析部分 mugen rv fail 用例问题。
    - iSulad: testcase 默认 registry 不可用；`lcr` runtime 不可用，需要切换至 `runc`
- 观测到 LTP 20230929 新版本发布，进行测试。
    - oErv 23.09 暂不跟进最新版本，维持 20230516 版本不变。
    - 结果见 [LTP-20230929](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/oErv-23.09-rc5/LTP-20230929)。
- 参加 openEuler sig-release-management 例会，同步 RISC-V 版本测试情况。
- 排查自动化测试用例 fail 包的情况
    - OpenIPMI: 仅 openhpi 构建时依赖 OpenIPMI-devel 包，其他无依赖；内核缺少配置 ipmi 相关模块，无法启动。RISC-V 目前对 OpenIPMI 需求不大。
        - 建议：移除 OpenIPMI 及其依赖。
- 校对&验证 openEuler 23.09 RISC-V QEMU 安装文档 [docs](https://gitee.com/KevinMX/open-euler-risc-v-23.09-test/blob/master/docs/InstallationBook/QEMU/README-new.md)
- 进行 oErv 23.09 RC7 / RC8 测试。 [commit](https://gitee.com/KevinMX/open-euler-risc-v-23.09-test/commit/395690dce6358648a258ccceb8725736472c08a8)
- 安装 oErv 23.09 GNOME 并验证可用性。[GNOME](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/oErv-23.09-rc5/GNOME)
- 编写脚本以自动化 LTP 和 dejagnu 测试。 [scripts](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/scripts)
- 更新 openEuler 23.09 RISC-V 官方文档 [PR !1667](https://gitee.com/openeuler/openEuler-portal/pulls/1667)
- 调研 RuyiSDK 测试方案，与组内同学讨论测试方案，初步形成部分测试用例 [RuyiSDK-test](https://github.com/ArielHeleneto/RuyiSDK-test)
- 基础设施运维工作，SSH 公钥验证 & SOP 编写。