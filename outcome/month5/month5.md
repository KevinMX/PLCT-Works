# month 5

记录本月产出。

1. 编写 openEuler 23.09 RISC-V RC1 测试报告：PR [!15](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/15), [!19](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/15)
2. 编写&完善 23.09 测试策略，并提交至 SIG-QA：PR [!532](https://gitee.com/openeuler/QA/pulls/532)，目前已通过 SIG-QA 评审。
3. 协助完成的单项测试内容，协助 @weilinfox 完成 openKylin v1.0 Lichee Pi 4A 的 autopkgtest，提供算力支持，并整理/修订所有文档。
4. 在 openEuler 23.09 RISC-V RC2 镜像上执行 Round 2 测试。[PR !54](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/54)
    - 编译器测试 / dejagnu
    - 长稳测试 / LTP Stress
    - 功能测试 / LTP
5. 与 openEuler 23.09 x86_64 RC3 对比结果。
    - 编译器测试 / [dejagnu](https://gitee.com/KevinMX/open-euler-risc-v-23.09-test/tree/master/Round2/BasicTest/compilers/dejagnu)
6. 在 openEuler 23.09 RISC-V RC2 镜像上执行 Round 3 测试。[Round3](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/Round3/BasicTest)
    - 编译器测试 / dejagnu
    - 编译器测试 / csmith
    - 功能测试 / LTP
    - 长稳测试 / LTPStress
7. 完成测试报告编写：[Report](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/blob/master/Round1/README.md), [PR](https://gitee.com/openeuler/QA/pulls/572)，已通过 SIG-QA 审查。
8. 更新&分析测试结果：https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round1/BasicTest
9. 参加 SIG-QA 会议，同步 oERV 测试进展。[etherpad](https://etherpad.openeuler.org/p/sig-QA-meetings)
10. 在 openEuler 23.09 RISC-V RC4 上执行 Round 4 测试。[Round4](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/Round3/BasicTest)