# k3s

一个轻量的 Kubernetes 发行版。

基于 Golang，目前在 openEuler RISC-V 24.04 LTS 有软件包可用。

## 测试环境

硬件：Sipeed Lichee Pi 4A 16GB

系统：openEuler 24.04 LTS RISC-V

- 镜像：https://mirror.sjtu.edu.cn/openeuler/openEuler-24.03-LTS/embedded_img/riscv64/lpi4a/
- 文档：https://docs.openeuler.org/zh/docs/24.03_LTS/docs/Installation/RISC-V-LicheePi4A.html
- 注意目前没有 GPU 和 Wi-Fi 驱动支持，你可能需要 USB-UART 调试器和有线网络连接来方便操作。

## 安装 k3s

直接从软件源安装：

```shell
sudo dnf install -y k3s
```

## 运行 k3s server

另起一个终端（可以使用 tmux/screen 等工具），以 root 身份执行：

```shell
k3s server
```

## 检查 k3s 运行状态

```shell
sudo k3s kubectl get node
sudo k3s kubectl get namespaces
```

## 屏幕录像

asciicast:

[![asciicast](https://asciinema.org/a/Bv4yX05tVXB2R2fLB2egEiBqr.svg)](https://asciinema.org/a/Bv4yX05tVXB2R2fLB2egEiBqr)

## 测试结论

- k3s server 可安装运行
- 除了系统本身之外，仅 k3s server 在不运行任何应用的情况下已经至少占用了 500M 内存，不推荐在内存受限设备上运行
- 官网安装脚本不可用（暂未提供 riscv64 支持）
- 由于绝大多数容器镜像没有针对 riscv64 提供构建，实际能够运行的应用并不多