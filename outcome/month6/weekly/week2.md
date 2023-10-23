## week 2

2023.10.16 ~ 2023.10.20

### 本周工作

- 参加 openEuler sig-release-management 例会，同步 RISC-V 版本测试情况。
- 排查自动化测试用例 fail 包的情况
    - OpenIPMI: 仅 openhpi 构建时依赖 OpenIPMI-devel 包，其他无依赖；内核缺少配置 ipmi 相关模块，无法启动。RISC-V 目前对 OpenIPMI 需求不大。
        - 建议：移除 OpenIPMI 及其依赖。
- 校对&验证 openEuler 23.09 RISC-V QEMU 安装文档 [docs](https://gitee.com/KevinMX/open-euler-risc-v-23.09-test/blob/master/docs/InstallationBook/QEMU/README-new.md)
- 进行 oErv 23.09 RC7 / RC8 测试。 [commit](https://gitee.com/KevinMX/open-euler-risc-v-23.09-test/commit/395690dce6358648a258ccceb8725736472c08a8)
- 安装 oErv 23.09 GNOME 并验证可用性。[GNOME](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/oErv-23.09-rc5/GNOME)
- 编写脚本以自动化 LTP 和 dejagnu 测试。 [scripts](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/scripts)