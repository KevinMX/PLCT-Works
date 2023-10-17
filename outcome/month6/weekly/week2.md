## week 2

2023.10.16 ~ 2023.10.20

### 本周工作

- 参加 openEuler sig-release-management 例会，同步 RISC-V 版本测试情况。
- 排查自动化测试用例 fail 包的情况
    - OpenIPMI: 仅 openhpi 构建时依赖 OpenIPMI-devel 包，其他无依赖；内核缺少配置 ipmi 相关模块，默认无法启动