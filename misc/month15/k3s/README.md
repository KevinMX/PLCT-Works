# k3s

一个轻量的 Kubernetes 发行版。

基于 [CARV-ICS-FORTH/kubernetes-riscv64](https://github.com/CARV-ICS-FORTH/kubernetes-riscv64) 的移植版本进行验证。

此移植版本默认已经为 manifest 做了修改。

## 测试环境

硬件：Milk-V Duo S (SG2000, 512M, microSD + Wi-Fi)

系统：Debian ([Fishwaldo/sophgo-sg200x-debian](https://github.com/Fishwaldo/sophgo-sg200x-debian))

用户名：debian

密码：rv

构建系统环境：Debian 12 bookworm x86_64 + Podman

## 前置准备

由于 K3s 依赖的部分内核选项没有默认开启，我们需要修改内核选项后重新编译内核。

### 准备编译环境

首先在系统上安装 Podman, git 等依赖软件包：

```shell
sudo apt update
sudo apt install -y podman git
```

```shell
git clone --depth=1 https://github.com/Fishwaldo/sophgo-sg200x-debian
cd sophgo-sg200x-debian
```


### 开启内核选项，重编内核

在 sophgo-sg200x-debian 目录下执行：

```conf
cat << EOF >> configs/duos/linux/defconfig
CONFIG_PROC_ID_CPUSET=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_NAMESPACES=y
CONFIG_OVERLAY_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EPOLL=y
CONFIG_IPV6=y
CONFIG_VETH=y
CONFIG_FANOTIFY=y
CONFIG_NETFILTER_XT_MATCH_IPVS=y
CONFIG_SMP=y
CONFIG_IP_VS=y
CONFIG_ZRAM=y
CONFIG_ZSMALLOC=y
EOF
```

启动&进入容器 Shell：

```shell
mkdir image
podman run --privileged -it --rm -v ./configs/:/configs -v ./image:/output ghcr.io/fishwaldo/sophgo-sg200x-debian:master make BOARD=duos linux
```

请确保网络连接畅通，中途需要连接至 ghcr.io 下载容器镜像。

等待编译结束后，sophgo-sg200x-debian 下的 image 目录会生成三个 deb 包，后面会将他们安装至开发板。

## 获取并刷写镜像

从 https://github.com/Fishwaldo/sophgo-sg200x-debian/releases/tag/v1.4.0 下载镜像。

选择 https://github.com/Fishwaldo/sophgo-sg200x-debian/releases/download/v1.4.0/duos_sd.img.lz4

下载之后解压文件。

```shell
sudo apt install -y lz4
lz4 -dk duos_sd.img.lz4
```

使用 dd 烧写镜像到 microSD 卡。

其中 `/dev/sdX` 为存储卡位置，对应实际位置修改。

或者在 Windows 下，解压镜像后使用 Rufus 工具烧录。

```shell
sudo dd if=duo_sd.img of=/dev/sdX bs=1M status=progress oflag=direct
```

## 启动开发板并安装新内核

将串口调试器连接到 Duo S 的串口排针上。请参考 Milk-V 官方文档提供的 [UART 串口调试台](https://milkv.io/zh/docs/duo/getting-started/duos#uart-%E4%B8%B2%E5%8F%A3%E6%8E%A7%E5%88%B6%E5%8F%B0)。 

注意不能使用 WCH CH340/341 系列调试器，串口乱码。推荐使用 CP210x 系列串口调试器。

插上烧录好镜像的 microSD 卡，连接网线，在 PC 端启动串口调试工具。

Windows 可使用 Putty，Linux 可使用 `screen` 或 `minicom`。

给开发板上电开机。

等待启动完成出现登录提示后：

```log
Debian GNU/Linux trixie/sid duos ttyS0

duos login: 
```

输入默认用户名 `debian` 和密码 `rv` 登录系统。

登录系统后，运行 `ip a` 查看当前 `end0` 接口的 IPv4 地址。

在电脑上通过 `scp` 将先前编译出的三个 `.deb` 软件包传输到存储卡。

下述 `a.b.c.d` 替换成上一步获取的 IP。

```shell
scp *.deb debian@a.b.c.d:/home/debian/
```
SCP 登录密码和先前一致为 `rv`。

由于目前编译出的 linux-image 包中并不包含 fdt/dtb，需要先对 extlinux 配置和 fdt/dtb 进行备份。

```shell
sudo cp /boot/extlinux/extlinux.conf /boot/extlinux/extlinux.conf.bak
sudo cp -vR /boot/fdt /boot/fdt_bak
```

然后即可卸载旧的内核包并安装新编译的内核包：

```shell
sudo apt remove linux-image-duos-5.10.4-20240527-2+
sudo dpkg -i ./*.deb
# 还原 extlinux.conf 和 dtb
sudo cp /boot/extlinux/extlinux.conf.bak /boot/extlinux/extlinux.conf
sudo cp -vR /boot/fdt_bak/* /boot/fdt/
```

安装结束后，重启开发板：`sudo reboot`

重启后请重新登录并获取 IP。Duo S 的有线网口默认没有固定 MAC 地址，因而有可能会被分配到新的 IP。

## 安装 k3s

使用了 [CARV-ICS-FORTH/kubernetes-riscv64](https://github.com/CARV-ICS-FORTH/kubernetes-riscv64) 的移植版本，默认已经为 manifest 做了修改。

在正式安装之前，需要先开启 zram 和 swap 以防内存不足（k3s server + node 仅运行就需要至少 512M 内存）。

```shell
sudo apt install -y zram-tools
sudo mkswap -U clear --size 1G --file /swapfile
sudo swapon /swapfile
```

之后即可安装 k3s。

```shell
sudo apt update && sudo apt install -y wget
wget https://github.com/CARV-ICS-FORTH/k3s/releases/download/20230721/k3s-riscv64.gz.aa
wget https://github.com/CARV-ICS-FORTH/k3s/releases/download/20230721/k3s-riscv64.gz.ab
wget https://github.com/CARV-ICS-FORTH/k3s/releases/download/20230721/k3s-riscv64.gz.ac
sudo sh -c 'cat k3s-riscv64.gz.* | gunzip > /usr/local/bin/k3s'
sudo chmod +x /usr/local/bin/k3s
wget -o k3s-install.sh https://get.k3s.io > k3s-install.sh
INSTALL_K3S_SKIP_DOWNLOAD="true" bash -x k3s-install.sh
```

安装最后阶段时，安装脚本会自动启动 k3s 服务。受限于 CPU 性能、运行内存大小和存储卡 I/O 性能，此步骤可能花费 40 分钟左右。请耐心等待。

## 检查 k3s 运行状态

```shell
sudo systemctl status k3s
sudo kubectl get node
sudo kubectl get namespaces
```

<!-- ## 运行 demo

提示：受限于性能和运行内存大小，此部分暂未在实机验证。在其他性能和内存充足的开发板上可以尝试运行。

目前来说，在 Duo S 这种 CPU 性能和 RAM 均受限的设备上，K3s 基本不具备实际可用性。

```shell
sudo kubectl apply -f https://raw.githubusercontent.com/CARV-ICS-FORTH/kubernetes-riscv64/main/examples/hello-kubernetes.yaml
sudo kubectl get pods -o wide
```

检查输出的 Node IP 和运行状态。若 Pod 为 Running 状态，接下来可尝试访问：

```shell
# 替换为上一步中获取的 IP
curl 10.42.0.9:8080
```

此时应该能够正常访问到 "Hello Kubernetes" 网页。

-->

## 测试结论

- k3s server 可安装运行
- 除了系统本身之外，仅 k3s server 在不运行任何应用的情况下已经至少占用了 500M 内存，非常不推荐在内存受限设备上运行
- 官网安装脚本不可用（暂未提供 riscv64 支持）
- 由于绝大多数容器镜像没有针对 riscv64 提供构建，实际能够运行的应用很少