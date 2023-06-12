## week 1

2023.6.5 ~ 2023.6.9

### 本周工作

1. 在实机上安装 openEuler x86_64，并执行 triniry 内核测试。运行三天暂未出现内核问题（软锁死/SIGSEGV 等）。

2. 排查 `tomcat` 疑似无法启动的问题，途中发现 JDK 11/17/19 在 6.1 内核下默认无法启动（见下方的缺陷报告），需要如下绕过方法：QEMU 启动选项添加`-cpu rv64,sv36=on \`。

3. QEMU 启动选项 `-cpu rv64,sv36=on` 后，重测了绝大部分先前需要降级内核否则无法启动/有严重问题的应用，目前已验证 Kiran、GNOME、Xfce、DDE、Firefox、lmbench、UKUI。

4. 更新 Kiran、GNOME、Xfce、DDE、UKUI、lmbench、trinity 文档。[commit](https://gitee.com/yunxiangluo/openeuler-riscv-2303-test/commit/2e3482434263e5dc0fa6930b852e6298fa5a07c9)

### 缺陷报告

新提交：

| ID     | 缺陷内容                                        | 状态           |
|--------|------------------------------------------------|----------------|
| I7BFDW | 23.03 QEMU 6.1.19 内核下 OpenJDK 11/17/19 无法启动| Done         |


先前已提交，复测已解决问题 Close：

| ID     | 缺陷内容                                        | 状态           |
|--------|------------------------------------------------|----------------|
| I6WRSY | 23.03 6.1 内核下无法启动 Firefox                  | Done          |

其他人提交，复测已解决问题，等待回复：

| ID     | 缺陷内容                                        | 状态           |
|--------|------------------------------------------------|----------------|
| I6TGR9 | 23.03 qemu ukui 桌面极为卡顿，无法启动任意gui 程序 | TBD, updated  |
| I6VGN4 | DDE 桌面环境登陆后崩溃                            | TBD, updated  |
| I70NSN | 23.03 xfce4-terminal 在用户输入时崩溃             | TBD, updated  |
