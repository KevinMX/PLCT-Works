# LPi4A 搭建 AP

## 前置依赖

- Sipeed Lichee Pi 4A 一块
- 系统已刷入 openEuler RISC-V (devel lpi4a_thead 镜像)
- 安装 `dnsmasq` 作为 DHCP 服务器。

> [!WARNING]
> 注意，不需要 *启用* 或 *启动* `dnsmasq.service`。`NetworkManager` 会自动调用 `dnsmasq` 二进制。


### 安装 dnsmasq

```bash
dnf install -y dnsmasq
```

## 配置 AP（无线接入点）

使用 `NetworkManager` 提供的 `nmcli` 进行配置。

替换 `con-name` 和 `ssid` 后的 `LPi4A_AP` 为您想要的连接名称和 SSID（WiFi 名称）。

```bash
nmcli device wifi hotspot ifname wlan0 con-name LPi4A_AP ssid LPi4A_AP password 12345678
nmcli con modify LPi4A_AP autoconnect yes
# 若 AP 未启动：
# nmcli con up LPi4A_AP
# 或者重启 NetworkManager：
# systemctl restart NetworkManager
```

> [!WARNING]
> 注意，此处默认您的无线网卡支持 AP 模式。有些（非 LPi4A 的 TH1520）开发板板载的是支持 5GHz Client 但不支持 AP 的无线网卡，需要手动更改为 2.4GHz 频段，可使用 `nmtui` 更改，或者：

```bash
nmcli con modify LPi4A_AP 802-11-wireless.band bg
```

## 配置防火墙

需要配置 `firewalld` 规则并写入持久化配置，以使确保连接到 AP 的设备也能连接到互联网。

注意，需要 LPi4A 已经接入了有线网络。

```bash
firewall-cmd --permanent --zone=public --add-masquerade
firewall-cmd --reload
```

> [!WARNING]
> 注意，Preview 版本的 `firewalld` 不工作，此处使用的为 devel 版本的 lpi4a_thead 镜像。
> 如您使用 Preview 版镜像，请改为使用 `iptables`：

```bash
iptables -t nat -A POSTROUTING -o end0 -j MASQUERADE
iptables -A FORWARD -i end0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o end0 -j ACCEPT
```

然后：

```bash
iptables-save >> /etc/sysconfig/iptables && \
systemctl disable --now firewalld && \
systemctl enable --now iptables
```

注意此方法可能无法正常使 `iptables` 规则持久化。仍建议使用 `firewalld`。

## 结束

至此，热点已经配置完成，连接到 AP 的客户端默认情况下会被分配 `10.42.0.0/24` 的 LAN IP。