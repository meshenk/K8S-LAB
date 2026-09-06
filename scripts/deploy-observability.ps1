$ErrorActionPreference = "Stop"
$env:KUBECONFIG = "D:\K8S-LAB\kubeconfig.yaml"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$manifests = "D:\K8S-LAB\k8s\observability"

Write-Host "Preparing hostPath and vm.max_map_count"
multipass exec rke2-server -- sudo sysctl -w vm.max_map_count=262144 | Out-Null
foreach ($n in @("rke2-server", "rke2-worker-1", "rke2-worker-2")) {
    multipass exec $n -- sudo mkdir -p /data/obs/prometheus /data/obs/loki /data/obs/elasticsearch /data/obs/filebeat
    multipass exec $n -- sudo chmod -R 777 /data/obs
}

Write-Host "Apply observability manifests"
kubectl apply -f $manifests

Write-Host "Wait for control-plane stack"
kubectl -n observability rollout status deploy/kube-state-metrics --timeout=300s
kubectl -n observability rollout status deploy/prometheus --timeout=360s
kubectl -n observability rollout status deploy/loki --timeout=360s
kubectl -n observability rollout status deploy/elasticsearch --timeout=420s
kubectl -n observability rollout status deploy/grafana --timeout=300s
kubectl -n observability rollout status ds/node-exporter --timeout=240s
kubectl -n observability rollout status ds/promtail --timeout=240s
kubectl -n observability rollout status ds/filebeat --timeout=240s

$serverIp = (multipass info rke2-server --format json | ConvertFrom-Json).info.'rke2-server'.ipv4[0]
Write-Host ""
Write-Host "Observability is up. Use server IP $serverIp"
Write-Host "  Grafana        http://${serverIp}:32000   admin / admin"
Write-Host "  Prometheus     http://${serverIp}:32090"
Write-Host "  Elasticsearch  http://${serverIp}:32200"
kubectl -n observability get pods,svc -o wide
