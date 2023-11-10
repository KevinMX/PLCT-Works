# Node.js 测试

## 概述

Node.js 是一个开源、跨平台的 JavaScript 运行环境。Node.js 可在浏览器之外执行 JavaScript 代码。

## 测试环境

本次分别在 x86_64 和 riscv64 两种架构下对 Node.js 进行了测试。详细信息如下：

x86_64:
- openEuler 23.09 x86_64
- 使用 openEuler 官方提供的 qcow2 虚拟机镜像 [openEuler-23.09-x86_64.qcow2.xz](https://repo.openeuler.org/openEuler-23.09/virtual_machine_img/x86_64/openEuler-23.09-x86_64.qcow2.xz)
- 宿主机：Proxmox VE 8.0.4（使用 qm import 方式导入 qcow2 镜像到虚拟机）
- QEMU 版本：8.0.2
- vCPU 分配：10
- RAM 分配：8GiB / 16GiB，开启 Balooning

riscv64:
- openEuler 23.09 RISC-V
- 使用 openEuler 官方源的 qcow2 虚拟机镜像与启动脚本 [openEuler-23.09-RISC-V-qemu-riscv64.qcow2.xz](https://repo.openeuler.org/openEuler-23.09/virtual_machine_img/riscv64/openEuler-23.09-RISC-V-qemu-riscv64.qcow2.xz) + 修改配置参数
- 宿主机：Arch Linux
- QEMU 版本：8.1.2
- vCPU 分配：18
- RAM 分配：16GiB
- 使用 tarsier-infra 仓库镜像 [ISCAS Mirror](https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20231106/v0.1/repo/) / [Tarsier-Infra Repo](https://repo.tarsier-infra.com/openEuler-RISC-V/obs/hwobs_2309_20231106/)

## 测试方法

使用自动化测试脚本：

```bash
curl -LO https://github.com/KevinMX/PLCT-Tarsier-Works/raw/main/misc/month7/node/scripts/node_test.sh && bash node_test.sh
```

## 测试结果

测试 log 详见：

- [x86_64](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month7/node/log/oEx86)
- [riscv64](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month7/node/log/oERV)

其中，x86_64 平台失败共 **3** 项：

```
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-tz-version.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/abort/test-abort-backtrace.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/wpt/test-url.js
```

riscv64 平台失败共 **74** 项：

```
out/Release/node --expose-internals /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-repl-history-navigation.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-runner-inspect.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-strace-openat-openssl.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-tls-root-certificates.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-tz-version.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-vm-global-non-writable-properties.js
out/Release/node --experimental-vm-modules /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-vm-module-synthetic.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-vm-strict-assign.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/parallel/test-wasm-web-api.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/abort/test-abort-backtrace.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/wpt/test-url.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-auto-resume.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-backtrace.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-break.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-breakpoint-exists.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-clear-breakpoints.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-custom-port.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-exceptions.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-exec.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-exec-scope.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-heap-profiler.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-help.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-launch.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-list.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-low-level.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-object-type-remote-object.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-pid.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-preserve-breaks.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-profile.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-profile-command.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-random-port.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-random-port-with-inspect-port.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-restart-message.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-run-after-quit-restart.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-sb-before-load.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-scripts.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-set-context-line-number.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-use-strict.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-watch-validation.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-debugger-watchers.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-http-econnrefused.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-http-max-sockets.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-http-regr-gh-2928.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-https-connect-localport.js
out/Release/node --expose-internals /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-inspector-async-hook-setup-at-signal.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-inspector-debug-brk-flag.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-inspector-enabled.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-net-GH-5504.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-net-connect-local-error.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-net-localport.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-net-server-bind.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-next-tick-error-spin.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-perf-hooks.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-pipe.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-tls-psk-client.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-tls-session-timeout.js
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-watch-mode.mjs
out/Release/node /home/openeuler/rpmbuild/BUILD/node-18.16.0/test/sequential/test-watch-mode-inspect.mjs
```

其中，x86_64 平台出现的 **3** 个失败项在 riscv64 平台**均有出现**。