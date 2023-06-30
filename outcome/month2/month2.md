# month 2

记录本月产出。

## 测试用例 / testcases

1. [A-Ops](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/A-Ops) （缺包）

2. [oncn-bwm](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/oncn-bwm)

3. [astream](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/astream)

> astream 依赖支持多流/multi stream 特性的 NVMe SSD，通常只有企业级 SSD 支持这个特性，QEMU 亦不支持模拟。缺少硬件条件暂时挂起测试。

4. [jtreg on OpenJDK 19](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test/JDK)

5. [trinity on openEuler x86_64 （实机）](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/BasicTest/%E5%86%85%E6%A0%B8%E6%B5%8B%E8%AF%95/trinity/x86_64)

6. QEMU 启动选项添加 `-cpu rv64,sv36=on` 后，复测了绝大部分先前需要降级内核否则无法启动/有严重问题的应用，目前已验证 Kiran、GNOME、Xfce、DDE、Firefox、lmbench、UKUI、trinity。- [commit](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/commit/2e3482434263e5dc0fa6930b852e6298fa5a07c9)



## 其他内容 / other stuff

1. 更新使用文档：[GNOME](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/User_Book/GNOME%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C), [Cinnamon](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/User_Book/Cinnamon%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8C)

2. 尝试在 oErv 23.03 下启动并测试 A-Ops, kubeOS, kubernetes(k8s), oncn-bwm，补全相关文档。[Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/tree/master/System_and_Feature_Test)

3. 编写基础测试&特性测试已知缺陷列表。- [Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/23.09/Basic_Feature_Test/IssueList.md)

4. 编写基础测试策略。- [Gitee](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/blob/master/23.09/Basic_Feature_Test/BasicTest_Strategy.md)

5. 汇总特性测试文档。- [GitHub](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/misc/month2/Feature_Test.md)

6. 排查 `tomcat` 疑似无法启动的问题，途中发现 JDK 11/17/19 在 6.1 内核下默认无法启动（见下方的缺陷报告），需要如下绕过方法：QEMU 启动选项添加`-cpu rv64,sv36=on \`。

7. 复测 oErv 23.02/23.03 所有先前已存在的 issue，联系相关参与者 Close 了部分（应用 Workaround 后）已解决的问题。

## 缺陷报告 / issues

本月新提交：

| ID                                                         | 缺陷内容                                           | 状态          |
|------------------------------------------------------------|------------------------------------------------|---------------|
| [I7BFDW](https://gitee.com/openeuler/RISC-V/issues/I7BFDW) | 23.03 QEMU 6.1.19 内核下 OpenJDK 11/17/19 无法启动 | Closed        |
| [I7FQJV](https://gitee.com/openeuler/RISC-V/issues/I7FQJV) | 23.03 oncn-bwm 无法开启带宽管理                    | TBD, Assigned |

经过复测验证已解决/应用 workaround 后可解决：

| ID                                                         | 缺陷内容                                                       | 状态          |
|------------------------------------------------------------|------------------------------------------------------------|---------------|
| [I6VGN4](https://gitee.com/openeuler/RISC-V/issues/I6VGN4) | DDE 桌面环境登陆后崩溃                                         | TBD, updated  |
| [I70NSN](https://gitee.com/openeuler/RISC-V/issues/I70NSN) | 23.03 xfce4-terminal 在用户输入时崩溃                          | TBD, updated  |
| [I6TGR9](https://gitee.com/openeuler/RISC-V/issues/I6TGR9) | 23.03 qemu ukui 桌面极为卡顿，无法启动任意gui 程序              | TBD, updated  |
| [I6QHWC](https://gitee.com/openeuler/RISC-V/issues/I6QHWC) | 23.02Kiran桌面安装报错                                         | TBD, 可 Close |
| [I6RRJT](https://gitee.com/openeuler/RISC-V/issues/I6RRJT) | 23.02k3s安装过程中出现的一些关于AST的报错                      | TBD, 可 Close |
| [I6RFYU](https://gitee.com/openeuler/RISC-V/issues/I6RFYU) | 23.02安装kiarn-desktop包后在终端切换用户提示“不能加载某些模块” | TBD, 可 Close |
| [I6QK77](https://gitee.com/openeuler/RISC-V/issues/I6QK77) | 23.02 kiran桌面在qemu无法正常启动                              | TBD, 可 Close |
| [I6QVEN](https://gitee.com/openeuler/RISC-V/issues/I6QVEN) | 23.02 cinnamon 从终端中启动 settings 报错                      | TBD, 可 Close |
| [I6O31D](https://gitee.com/openeuler/RISC-V/issues/I6O31D) | ukui-control-center 无法添加/修改 用户/用户组及相关选项        | TBD, 可 Close |
| [I6TGR9](https://gitee.com/openeuler/RISC-V/issues/I6TGR9) | 23.03 qemu ukui 桌面极为卡顿，无法启动任意gui 程序              | Closed        |
| [I6WRSY](https://gitee.com/openeuler/RISC-V/issues/I6WRSY) | 23.03 6.1 内核下无法启动 Firefox                               | Closed        |
| [I6QHS3](https://gitee.com/openeuler/RISC-V/issues/I6QHS3) | 23.02 ukui 无法使用回收站                                      | Closed        |

经过复测验证确认仍存在问题：

| ID                                                         | 缺陷内容                                 | 状态 |
|------------------------------------------------------------|--------------------------------------|------|
| [I6Q24G](https://gitee.com/openeuler/RISC-V/issues/I6Q24G) | 23.02 ukui 登录界面间歇性卡住            | TBD  |
| [I6O3AY](https://gitee.com/openeuler/RISC-V/issues/I6O3AY) | gnome 缺陷：gnome-control-center 启动报错 | TBD  |
