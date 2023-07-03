## week 3-4

2023.6.19 ~ 2023.6.30

### 本周工作

1. 编写基础测试&特性测试已知缺陷列表。- [Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/23.09/Basic_Feature_Test/IssueList.md)

2. 编写基础测试策略。- [Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/23.09/Basic_Feature_Test/BasicTest_Strategy.md)

3. 汇总特性测试文档。- [/misc](/misc/month2/Feature_Test.md)

4. 测试 oncn-bwm 和 astream。- [Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test)

> astream 依赖支持多流/multi stream 特性的 NVMe SSD，通常只有企业级 SSD 支持这个特性，QEMU 亦不支持模拟。缺少硬件条件暂时挂起测试。

5. 复测所有先前已存在的 issue，联系相关参与者 Close 了一部分已经解决的问题。

### 缺陷报告

新添加：

| ID                                                         | 缺陷内容                         | 状态          |
|------------------------------------------------------------|------------------------------|---------------|
| [I7FQJV](https://gitee.com/openeuler/RISC-V/issues/I7FQJV) | 223.03 oncn-bwm 无法开启带宽管理 | TBD, Assigned |

复测验证已解决/应用 workaround 后解决：

| ID                                                         | 缺陷内容                                                       | 状态          |
|------------------------------------------------------------|------------------------------------------------------------|---------------|
| [I6QHWC](https://gitee.com/openeuler/RISC-V/issues/I6QHWC) | 23.02Kiran桌面安装报错                                         | TBD, 可 Close |
| [I6RRJT](https://gitee.com/openeuler/RISC-V/issues/I6RRJT) | 23.02k3s安装过程中出现的一些关于AST的报错                      | TBD, 可 Close |
| [I6RFYU](https://gitee.com/openeuler/RISC-V/issues/I6RFYU) | 23.02安装kiarn-desktop包后在终端切换用户提示“不能加载某些模块” | TBD, 可 Close |
| [I6QHS3](https://gitee.com/openeuler/RISC-V/issues/I6QHS3) | 23.02 ukui 无法使用回收站                                      | Closed        |
| [I6QK77](https://gitee.com/openeuler/RISC-V/issues/I6QK77) | 23.02 kiran桌面在qemu无法正常启动                              | TBD, 可 Close |
| [I6QVEN](https://gitee.com/openeuler/RISC-V/issues/I6QVEN) | 23.02 cinnamon 从终端中启动 settings 报错                      | TBD, 可 Close |
| [I6O31D](https://gitee.com/openeuler/RISC-V/issues/I6O31D) | ukui-control-center 无法添加/修改 用户/用户组及相关选项        | TBD, 可 Close |

复测验证仍存在问题：

| ID                                                         | 缺陷内容                                 | 状态 |
|------------------------------------------------------------|--------------------------------------|------|
| [I6Q24G](https://gitee.com/openeuler/RISC-V/issues/I6Q24G) | 23.02 ukui 登录界面间歇性卡住            | TBD  |
| [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY) | gnome 缺陷：gnome-control-center 启动报错 | TBD  |
