## week 4

2023.12.25 ~ 2023.12.29

### 本周工作

> 身体原因，本周请假数天，产出受此影响。

- 硬件/开发板测试
    - [LTP on SG2042 (Milk-V Pioneer v1.3)](/misc/month8/RevyOS_20231220_Pioneer_v1p3/LTP/)
    - 测试脚本 - [LTP_Pioneer_RevyOS.sh](/misc/scripts/LTP_Pioneer_RevyOS.sh)

Pioneer v1.3 / RevyOS 20231220 测试结果：

- 39 项失败。
- 约一半为非问题/预料中的失败。

- openEuler 24.03 RISC-V 测试准备
    - SIG-QA 沟通会，交流南向兼容性、部分测试工具不可用等问题 [会议纪要](https://gitee.com/yunxiangluo/openEuler-RISCV-2403LTS-Pretest/blob/master/Meeting_Notes.md)
    - 测试策略编写：[PR](https://gitee.com/yunxiangluo/openEuler-RISCV-2403LTS-Pretest/pulls/1)