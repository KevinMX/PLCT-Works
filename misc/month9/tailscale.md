# Tailscale on SG2042 Pisces, Fedora 38 RISC-V

## 安装

安装前需验证内核已开启 TUN 支持，即 CONFIG_TUN=y 或 m。

```bash
zgrep CONFIG_TUN /proc/config.gz
```

输出：

```bash
$ zgrep CONFIG_TUN /proc/config.gz
CONFIG_TUNE_GENERIC=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
```

官方已经提供了 tailscale 本体的 RISC-V 构建，直接拉取官方源。但由于官方源速度较慢，目前使用了 Cloudflare Workers 作为反代加速。

> Workers Proxy 需要自行搭建，将 [此 URL](https://github.com/netnr/workers/blob/main/pages/_worker.js) 中的内容复制进 Workers 内即可。当然，也可使用 Wrangler CLI 进行部署。

> 若在 Cloudflare 有域名，推荐使用自定义域名而非 workers.dev 以规避针对此域名的 DNS 污染。

```bash
export PROXY="https://proxy.example.com/"
sudo dnf config-manager --add-repo ${PROXY}https://pkgs.tailscale.com/stable/fedora/38/tailscale.repo
sudo dnf install -y tailscale
```

## 接入 tailnet

启用 & 启动 tailscaled 服务。

```bash
sudo systemctl enable --now tailscaled.service
sudo tailscale up --accept-dns=false
```

控制台会输出一个 URL，在浏览器中打开此 URL 并登录。如果先前没有账号，推荐使用微软账号登录。

`--accept-dns` 在部分配置上可能导致问题，建议禁用。

登录好账号之后，当前机器就会出现在 [Tailscale 控制台](https://login.tailscale.com/admin/machines) 中了。

## 搭建 DERP 中继节点

使用了 [Docker](https://hub.docker.com/r/dextercai/derper) 搭建 DERP，详细信息请参见 README。

> 同时也支持 K3s Helm Chart。

此外，80/443 端口受限的场景，需要使用 acme.sh 或类似项目先申请证书，再挂载进容器内。

> 若使用 K3s，可以配置 Ingress 来使用 TLS 证书。

搭建好后，在 Tailscale 网页端控制台添加如下 ACL / Access Control 规则：

```json
	"derpMap": {
		"OmitDefaultRegions": true, //此项设置为 true 以屏蔽官方 DERP 中继服务器
		"Regions": {
			"900": {
				"RegionID":   900,
				"RegionCode": "sha",
				"RegionName": "Shanghai",
				"Nodes": [
					{
						"Name":     "my-server",
						"RegionID": 900,
						"HostName": "my-server.ip.addr",
                        // "IPv4": "", //若 DNS 不生效可以配置此项，但必须配置 HostName 否则无法验证 TLS SNI
						"DERPPort": 443,    //更改为实际端口
						"STUNPort": 3478,   //更改为实际端口
					},
				],
			},
		},
	},
```

接下来可以尝试在其他启动了 Tailscale 的机器上 ping 目标机器了。

```bash
tailscale ping machine
```

出现如下信息表示 DERP 已正常工作。（IP 和 hostname 仅作示意。）

```bash
$ tailscale status # 查看网络上的所有机器，获取机器对应的域名
**REDACTED**   hostname.tail*****.ts.net **********@ linux   idle, tx 22112 rx 15112
$ tailscale ping hostname
pong from hostname (**REDACTED**) via DERP(sha) in 29ms
```

## 已知问题

若将配置了 DERP share out 给其他账号，在另一个账号下无法连接，即使两端配置了同样的 DERP 服务器。

解决方案：将两个账号通过邀请方式加入同一个 tailnet，并配置 ACL 规则限制访问权限。