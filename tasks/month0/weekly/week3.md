# week 3

## 本周计划

- Priority 0: 根据 QA 组需求进行测试，本周针对基础测试部分，测试平台暂时以 QEMU 为主。见 [openeuler/QA/openEuler社区测试能力执行指南](https://gitee.com/openeuler/QA/blob/master/openEuler%E7%A4%BE%E5%8C%BA%E6%B5%8B%E8%AF%95%E8%83%BD%E5%8A%9B%E6%89%A7%E8%A1%8C%E6%8C%87%E5%8D%97/openEuler%E7%A4%BE%E5%8C%BA%E6%B5%8B%E8%AF%95%E8%83%BD%E5%8A%9B%E6%89%A7%E8%A1%8C%E6%8C%87%E5%8D%97.md)

> 基础测试部分全部需要进行测试，从基础性能测试部分开始。目前已知：netperf, fio, lmbench 源内有包

- 排查 iSulad Native Network / CNI 插件无法启动的原因。
- 先前测试过程中发现的部分问题，本周将提交缺陷报告。e.g. Cinnamon, iSulad Native Network / CNI

> TODO: TODO

### 当前进度

|名称|状态|说明|
|-|-|-|
|unixbench|Done|[日志](/misc/month1/week3-QA/unixbench.log)|
|netperf|TBD|组内其他成员在做|
|libmicro|Done|[日志](/misc/month1/week3-QA/libMicro.log)|
|fio|Done|[日志](/misc/month1/week3-QA/fio.log) / [脚本](/misc/month1/week3-QA/fio.sh)|
|stream|Done|[日志](/misc/month1/week3-QA/stream.log)|
|lmbench|Done|[日志](/misc/month1/week3-QA/lmbench.log)，可运行，有内核报错，需要替换 gnu-os 脚本至新版本 ([source](https://git.savannah.gnu.org/cgit/config.git/plain/config.guess))，PR 已提交上游 [!18 Update gnu-os and spec](https://gitee.com/src-openeuler/lmbench/pulls/18) （等待合并）|
|长稳测试 LTP Stress|WIP|先前多次中断，最后一次中断确认和内存不足有关，尝试增大内存分配并更新 QEMU 8.0 后重新运行中，先前的部分日志位于 [此处](/misc/month1/week3-QA/)；测试时间较长（需要运行至少 24h）|