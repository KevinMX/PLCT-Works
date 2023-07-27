# kpatch

## 概述

kpatch 是用于 Linux 内核动态补丁的工具，允许用户在不重启系统、不重启任何进程的情况下对运行中的内核进行修补。kpatch 使系统管理员能随时应用关键的安全补丁，无须等待长时间运行的任务完成，等待用户登出系统，或者计划好的重新启动窗口期。kpatch 在保证安全和稳定性的前提下给予了用户更多的控制。

## 测试环境

- 系统版本：openEuler 23.03 RISC-V Preview (base 镜像)
- 内核版本：6.4.0-1.0.0.4.oe2309.riscv64（23.09 / Mainline 内核）
- 虚拟机版本：QEMU 8.0.2

> 由于 oErv 23.03 的内核不提供 kpatch 所需的 debuginfo 包，加之其他测试需要，笔者暂时采用了 Mainline 构建工程中的 6.4 内核。

## 测试步骤

0. 前置步骤：安装 6.4 内核。注意，除了内核本体，`debuginfo`, `devel` 和 `source` 包也需要安装。这些是 `kpatch` 的依赖。

从此处获取（需要登录）：https://build.tarsier-infra.com/package/show/openEuler:Mainline/kernel

然后安装这些包（请切换至 root 用户）

```bash
dnf install -y kernel-6.4.0-1.0.0.4.oe2309.riscv64.rpm kernel-{source,debuginfo,devel}-6.4.0-1.0.0.4.oe2309.riscv64.rpm
```

安装完毕后，修改 /boot/extlinux/extlinux.conf，将 `vmlinuz-openEuler` 修改为 `vmlinuz-6.4.0-1.0.0.4.oe2309.riscv64`。

```bash
sed -i "s/vmlinuz-openEuler/vmlinuz-6.4.0-1.0.0.4.oe2309.riscv64/g" /boot/extlinux/extlinux.conf
```

然后重启系统。

1. 安装所需软件包。

```bash
dnf install -y make gcc patch bison flex openssl-devel kpatch kpatch-runtime elfutils-libelf-devel
```

2. 进入热补丁制作目录并准备环境。


```bash
cd /opt/patch_workspace
rm -rf kernel-source .config
ln -s /usr/src/linux-`uname -r`/ kernel-source
ln -s /usr/src/linux-`uname -r`/.config .config
ln -s /usr/lib/debug/lib/modules/`uname -r`/vmlinux vmlinux
```

3. 制作内核热补丁（以 tcp_bbr 为例）。

```bash
cd kernel-source
cd net/ipv4
cp tcp_bbr.c tcp_bbr.c.new
```

修改 `tcp_bbr.c.new` 中的函数，如，将第 191 行的：

```C
static const u32 bbr_lt_bw_diff = 4000 / 8;
```

更改为

```C
static const u32 bbr_lt_bw_diff = 4000000 / 8;
```

4. 制作热补丁。

```bash
cd /opt/patch_workspace/
./make_hotpatch -d .new -i bbr
```

5. 应用热补丁。

```bash
livepatch -a bbr
```

## 预期结果

成功制作并应用热补丁。

## 实际结果

热补丁制作失败，日志输出如下。

```bash
[root@openeuler-riscv64 patch_workspace]# ./make_hotpatch -d .new -i bbr
kernel version:6.4.0-1.0.0.4.oe2309.riscv64
grep: warning: stray \ before -
grep: warning: stray \ before -
grep: warning: stray \ before -
detect change files:/usr/src/linux-6.4.0-1.0.0.4.oe2309.riscv64/net/ipv4/tcp_bbr.c.new
make patch /tmp/klp_bbr/bbr.patch
Using source directory at /usr/src/linux-6.4.0-1.0.0.4.oe2309.riscv64
WARNING: Use of kpatch core module (kpatch.ko) is deprecated!  There may be bugs!
ERROR: unable to find Module.symvers for kpatch core module.
error: invoke kpatch-build shell script to build patch failed
[root@openeuler-riscv64 patch_workspace]#
```

## 参考文档

[dynup/kpatch（上游）](https://github.com/dynup/kpatch)

[src-openEuler/kpatch](https://gitee.com/src-openEuler/kpatch)