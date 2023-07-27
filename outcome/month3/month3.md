# month 3

记录本月产出。

- 准备 `oErv 23.03 测试策略与结果同步` 演示文稿。[QA](https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/reports/month3/month3-QA.md)

- 对 oErv 23.09 kernel 6.4 进行初步测试，并进行结果分析：[LTP & trinity](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month3/23.09-kernel-6.4-pretest)

- 整理测试策略以方便日后测试工作的开展，以及日后提交给 sig-QA 进行评审。- [oErv-2303-test](https://gitee.com/yunxiangluo/oerv-2303-test)

- 尝试执行 kubernetes E2E 测试：[Gitee](https://gitee.com/KevinMX/openeuler-riscv-2303-test/commit/069176111d42a5f29a0a0b08d3b94c1de4beba20)

> `kubetest` 测试组件已被 kubernetes 上游 deprecated。

- 调研&尝试在现有的 6.4 内核上使用 `kpatch` 对内核进行热补丁，产出测试用例&文档见：[misc/kpatch](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month3/kpatch)

> mugen BaseOS 已包含对 `kpatch.service` 启动的测试，已通过。

- 调研 `greatsql`。

> mugen 已包含对 `mysqlrouter.service` 启动的测试，已通过。