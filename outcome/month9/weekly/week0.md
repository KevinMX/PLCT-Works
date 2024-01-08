## week 0

2024.01.02 ~ 2024.01.05

### 本周工作

- oERV 24.03 测试调研工作
    - mmtest on oERV 测试/摸底工作
        - SG2042 上能跑通，由于出现了计划外的硬件问题（PCI-E Switch 风扇故障），为避免桥片过热损坏，测试暂时中断，等待新风扇到货后继续
        - mmtest 会拉起 LTP 进行测试，有重叠部分
        - 安装脚本更新：[commit](https://gitee.com/KevinMX/ltpstress-for-openeuler/commit/49135c9c02a2f8bfd2af28ae3756d9d8d4e56234)
    - 测试策略更新：[PR](https://gitee.com/yunxiangluo/openEuler-RISCV-2403LTS-Pretest/pulls/2)
    - 测试结果分析
        - LPi4A: LTP [oERV](/misc/month8/2309-hw-pre_mainline/LTP/LPi4A/)
        - Pioneer: LTP [oERV](/misc/month8/2309-hw-pre_mainline/LTP/Pioneer_v1p3/result_analysis.csv) / [RevyOS](/misc/month8/RevyOS_20231220_Pioneer_v1p3/result-analysis.csv)
- 山大 SG2042 服务器网络接入
    - 搭建 Tailscale DERP 中继节点，优化国内连接延迟
    - 尝试解决 Share out machine 无法使用自建 DERP 节点的问题
    - 记录 [文档](/misc/month9/tailscale.md)
- 调查 oERV perf top SIGSEGV 问题，并提交 core dump 结果：[I8TLYZ](https://gitee.com/openeuler/RISC-V/issues/I8TLYZ?from=project-issue#note_24150341_link)