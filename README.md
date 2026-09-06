# K8S-LAB：RKE2 一主两从 + X1 高可用实验环境

本仓库只保留 **集群基础设施** 和 **X1 业务**。在 Windows 上用 Terraform + Multipass（Hyper-V）拉起 RKE2，再把 X1 管理端 / 移动端 / Pad 以双副本打散到两台 worker，并用 Prometheus、Grafana、Loki、Elasticsearch 做运维监测。

## 先读这些文档

| 文档 | 内容 |
| --- | --- |
| [docs/01-设计说明与高可用架构.md](docs/01-设计说明与高可用架构.md) | 为什么这样设计、高可用边界、X1 流量与故障域 |
| [docs/02-Terraform与RKE2技术栈.md](docs/02-Terraform与RKE2技术栈.md) | Terraform、Multipass、RKE2、国内镜像、cloud-init |
| [docs/03-运维监测.md](docs/03-运维监测.md) | Prometheus / Grafana / Loki / Elasticsearch 怎么部署、怎么用 |

## 当前实测拓扑

```text
 Windows 主机
   Terraform / kubectl / Multipass
            |
     Hyper-V Default Switch
            |
 +----------+----------------+----------------+
 | rke2-server               | rke2-worker-1  | rke2-worker-2
 | RKE2 server + etcd        | RKE2 agent     | RKE2 agent
 | 控制面 NoSchedule         | X1 业务        | X1 业务
 | 观测栈（Prom/Grafana/     | MySQL / EMQX   | Redis / MinIO
 | Loki / ES）               | Java + Nginx   | Java + Nginx
 +---------------------------+----------------+----------------+
```

| 节点 | 角色 | 规格 | 本次 IPv4 | 版本 |
| --- | --- | --- | --- | --- |
| `rke2-server` | control-plane, etcd | 2C / 4G / 40G | `172.26.220.97` | `v1.36.4+rke2r1` |
| `rke2-worker-1` | worker | 2C / 4G / 30G | `172.26.217.44` | 同上 |
| `rke2-worker-2` | worker | 2C / 4G / 30G | `172.26.215.60` | 同上 |

Hyper-V Default Switch 走 DHCP，**重启后 IP 可能变**。变了就重拉 kubeconfig，不要改业务清单里的 `HOST_IP` 以外的东西去 `terraform apply`。

```powershell
$env:KUBECONFIG = "D:\K8S-LAB\kubeconfig.yaml"
kubectl get nodes -o wide
```

PowerShell 里必须用 `$env:KUBECONFIG = "..."`。CMD 的 `set KUBECONFIG=...` 对当前 PowerShell 会话无效，会误打到 Rancher Desktop 的 `127.0.0.1:6443`。

## 仓库目录

```text
D:\K8S-LAB
├── deploy.ps1                      # terraform init + apply，创建集群
├── destroy.ps1                     # 销毁三台虚拟机
├── kubeconfig.yaml                 # apply 后生成，不要提交
├── docs\                           # 设计 / 技术栈 / 监测说明
├── terraform\                      # IaC：渲染 cloud-init，调用 Multipass
├── scripts\
│   ├── launch-*.ps1 / delete-*.ps1 # Terraform local-exec 包装 Multipass
│   ├── fetch-kubeconfig.ps1
│   ├── wait-nodes.ps1
│   ├── deploy-x1-ha.ps1            # 同步制品并部署 X1
│   └── deploy-observability.ps1    # 部署监测栈
├── k8s\
│   ├── x1\                         # X1 中间件 / Java / Nginx
│   └── observability\              # Prom + Grafana + Loki + ES
└── deploy\deploy_local\deploy_local\   # X1 本地包（前端 dist / SQL；JAR 见下）
```

GitHub 不收录超过 100MB 的文件。两个 Java JAR（各约 320MB）、Docker Desktop 安装包和前端 zip 备份已在 `.gitignore` 里排除。克隆后请把 `x1-admin-api.jar` / `x1-mobile-api.jar` 放回：

```text
deploy\deploy_local\deploy_local\jar\admin\x1-admin-api.jar
deploy\deploy_local\deploy_local\jar\mobile\x1-mobile-api.jar
```

## 一键操作

**1. 建集群（空集群，约 15–30 分钟）**

```powershell
.\deploy.ps1
```

已经 Ready 的集群 **不要再 apply**。改 cloud-init 模板会改 worker 哈希，Terraform 会重建 worker，X1 的 hostPath 数据会丢。

**2. 部署 X1**

```powershell
$env:KUBECONFIG = "D:\K8S-LAB\kubeconfig.yaml"
powershell -File D:\K8S-LAB\scripts\deploy-x1-ha.ps1
```

**3. 部署监测**

```powershell
powershell -File D:\K8S-LAB\scripts\deploy-observability.ps1
```

## X1 入口

把 IP 换成当前任意 worker 地址即可（NodePort 在两台 worker 上都通）。

| 入口 | 地址 |
| --- | --- |
| PC 管理端 | http://172.26.217.44:30999 |
| 移动端 | http://172.26.217.44:30998 |
| Pad | http://172.26.217.44:30995 |
| Admin API | http://172.26.217.44:30092/x1-admin-api |
| Mobile API | http://172.26.217.44:30094/x1-mobile-api |
| MinIO 控制台 | http://172.26.217.44:30901 |
| EMQX 控制台 | http://172.26.217.44:31884 （`admin` / `admin123`） |

## 监测入口

观测组件挂在 **控制面**，避免再挤 worker 上的 Java。从主机访问 **server IP** 的 NodePort。

| 入口 | 地址 | 账号 |
| --- | --- | --- |
| Grafana | http://172.26.220.97:32000 | `admin` / `admin` |
| Prometheus | http://172.26.220.97:32090 | 无 |
| Elasticsearch | http://172.26.220.97:32200 | 无（实验室关闭 xpack） |

## 不要做的事

- 不要 `terraform apply` 去改已运行集群的 cloud-init / worker 规格。
- 不要把业务 Pod 指到 `rke2-server`（默认 NoSchedule）。观测栈是唯一刻意容忍该污点的工作负载。
- 不要和 Rancher Desktop 共用默认 kubeconfig。
- 本仓库不再包含 mall4cloud、示例 nginx 或其他演示项目。
