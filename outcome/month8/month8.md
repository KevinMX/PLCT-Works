# month 7

记录本月产出。

### RuyiSDK

- ruyi v0.2 pre_round5 测试工作：[PR!8](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/8), [PR!9](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/9)
    - LPi4A on openEuler 23.09 RISC-V preview
    - SG2042 (Milk-V Pioneer v1.1) on Fedora 38
- ruyi v0.2 round1 1204 版本测试工作：[PR!10](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/10)
    - SG2042 (Milk-V Pioneer v1.1) on openEuler 23.09 RISC-V preview
- ruyi v0.2 round 2 1211 版本测试：
    - [Round 2 测试报告模板：PR !16](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/14)
    - [Lichee Pi 4A: PR !16](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/16)
    - 更新 mugen-ruyi 代码：[使用 dnf 直接从 URL 安装 rpm](https://gitee.com/weilinfox/mugen-ruyi/pulls/1)

RuyiSDK round2 测试：ruyi v0.2 (20231211) 版本
- [SG2042 / oERV](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/18)
- [SG2042 / Fedora 38](https://gitee.com/yunxiangluo/ruyi-sdk-v0.2-test/pulls/17)

### 硬件开发板测试

openEuler RISC-V: 

- [LTP on LicheePi 4A](/misc/month8/2309-hw-pre_mainline/LTP/LPi4A/)
- 测试脚本 - [LPi4A](/misc/scripts/LTP_LPi4A.sh)

RevyOS:
- [LTP on SG2042 (Milk-V Pioneer v1.3)](/misc/month8/RevyOS_20231220_Pioneer_v1p3/LTP/)
- 测试脚本 - [LTP_Pioneer_RevyOS.sh](/misc/scripts/LTP_Pioneer_RevyOS.sh)

Pioneer v1.3 / RevyOS 20231220 测试结果：
- 39 项失败。
- 约一半为非问题/expected fail。

- openEuler 24.03 RISC-V 测试准备
    - SIG-QA 沟通会，交流南向兼容性、部分测试工具不可用等问题 [会议纪要](https://gitee.com/yunxiangluo/openEuler-RISCV-2403LTS-Pretest/blob/master/Meeting_Notes.md)
    - 测试策略编写：[PR](https://gitee.com/yunxiangluo/openEuler-RISCV-2403LTS-Pretest/pulls/1)