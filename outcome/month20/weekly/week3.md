# week 3 / 本周工作

2024.12.16 ~ 2024.12.20

## 操作系统支持矩阵

PR Review:

| PR                                                 | Content                                          | Status |
| -------------------------------------------------- | ------------------------------------------------ | ------ |
| https://github.com/ruyisdk/support-matrix/pull/115 | Split LicheeRV and Nezha                         | Merged |
| https://github.com/ruyisdk/support-matrix/pull/116 | Added AlpineLinux report for BPI-F3              | Merged |
| https://github.com/ruyisdk/support-matrix/pull/117 | BeagleV-Ahead: add RevyOS and openSUSE           | Merged |
| https://github.com/ruyisdk/support-matrix/pull/119 | licheervnano: Add/Update Alpine/BuildRoot/Fedora | Merged |
| https://github.com/ruyisdk/support-matrix/pull/120 | CI: Add CI for package index sync                | Merged |
| https://github.com/ruyisdk/support-matrix/pull/121 | fix typo in Duo_S link                           | Merged |

RuyiSDK 双周报/支持矩阵部分：

https://github.com/ruyisdk/wechat-articles/pull/116

### 其他内容

- 组内 Infra 维护
        - 调查 Pioneer 构建软件包/高负载时偶发的异常死机
            - 切换至使用 6.6 内核的 RevyOS
            - 使用 chroot 继续构建工作
    - 跳板机/成员 SSH Key 日常维护
    - 搭建组内 Infra Uptime 观测（目前开放对外访问）：https://radiata.kevinmx.top
- （week 2 休假期间）主持了 [第 93 次 RISC-V 东亚双周会](https://community.riscv.org/events/details/risc-v-international-risc-v-in-china-presents-dong-ya-shi-qu-shuang-zhou-hui-di-93ci-east-asia-risc-v-sync-up-call/)