## week 1

2023.10.07 ~ 2023.10.13

### 本周工作

- 补充 openEuler 23.09 RISC-V RC4 测试报告/LTP Long Stress [PR !72](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/pulls/72)
- 在 openEuler 23.09 RISC-V RC5 上执行 Round 5 测试。[Round5](https://gitee.com/yunxiangluo/open-euler-risc-v-23.09-test/tree/master/Round5/BasicTest)
- 分析部分 mugen rv fail 用例问题。
    - iSulad: testcase 默认 registry 不可用；`lcr` runtime 不可用，需要切换至 `runc`
- 观测到 LTP 20230929 新版本发布，进行测试。
    - oErv 23.09 暂不跟进最新版本，维持 20230516 版本不变。
    - 结果见 [LTP-20230929](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month6/oErv-23.09-rc5/LTP-20230929)。