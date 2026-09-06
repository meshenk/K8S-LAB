$ErrorActionPreference = "Stop"
$env:KUBECONFIG = "D:\K8S-LAB\kubeconfig.yaml"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$src = "D:\K8S-LAB\deploy\deploy_local\deploy_local"
$k8s = "D:\K8S-LAB\k8s\x1"

Write-Host "Preparing hostPath on workers"
foreach ($n in @("rke2-worker-1", "rke2-worker-2")) {
    multipass exec $n -- sudo mkdir -p /data/x1/mysql /data/x1/redis /data/x1/minio /data/x1/emqx /data/x1/jars /data/x1/fonts /data/x1/html
    multipass exec $n -- sudo chmod -R 777 /data/x1
}

Write-Host "Sync jars and fonts"
foreach ($n in @("rke2-worker-1", "rke2-worker-2")) {
    multipass transfer "$src\jar\admin\x1-admin-api.jar" "${n}:/tmp/x1-admin-api.jar"
    multipass exec $n -- sudo cp /tmp/x1-admin-api.jar /data/x1/jars/x1-admin-api.jar
    multipass transfer "$src\jar\mobile\x1-mobile-api.jar" "${n}:/tmp/x1-mobile-api.jar"
    multipass exec $n -- sudo cp /tmp/x1-mobile-api.jar /data/x1/jars/x1-mobile-api.jar
    multipass transfer "$src\jar\admin\fonts\simhei.ttf" "${n}:/tmp/simhei.ttf"
    multipass transfer "$src\jar\admin\fonts\simsunextg.ttf" "${n}:/tmp/simsunextg.ttf"
    multipass exec $n -- sudo cp /tmp/simhei.ttf /tmp/simsunextg.ttf /data/x1/fonts/
}

Write-Host "Sync frontend dist (tar)"
$tar = "D:\K8S-LAB\k8s\x1\html.tgz"
if (-not (Test-Path $tar)) {
    tar -czf $tar -C "$src\html" x1pc x1mobile x1pad
}
foreach ($n in @("rke2-worker-1", "rke2-worker-2")) {
    multipass transfer $tar "${n}:/tmp/html.tgz"
    multipass exec $n -- sudo tar -xzf /tmp/html.tgz -C /data/x1/html
}

Write-Host "Apply middleware"
kubectl apply -f "$k8s\10-middleware.yaml"
kubectl -n x1 rollout status statefulset/mysql --timeout=300s
kubectl -n x1 rollout status deploy/redis --timeout=180s
kubectl -n x1 rollout status deploy/minio --timeout=180s
kubectl -n x1 rollout status deploy/emqx --timeout=180s

Write-Host "Import x1.sql"
$tmpDir = Join-Path $env:TEMP "x1-import"
New-Item -ItemType Directory -Force -Path $tmpDir | Out-Null
Copy-Item "$src\x1.sql" "$tmpDir\x1.sql" -Force
Push-Location $tmpDir
try {
    kubectl cp x1.sql x1/mysql-0:/tmp/x1.sql
} finally {
    Pop-Location
}
kubectl -n x1 exec mysql-0 -- sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" x1 < /tmp/x1.sql'

Write-Host "MinIO bucket"
kubectl -n x1 exec deploy/minio -- sh -c 'mc alias set local http://127.0.0.1:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD" && mc mb -p local/wlwtest'

Write-Host "Apply apps and nginx"
kubectl apply -f "$k8s\20-apps.yaml"
kubectl apply -f "$k8s\30-nginx.yaml"

Write-Host "Wait nginx"
kubectl -n x1 rollout status deploy/x1-web --timeout=180s
Write-Host "Done. Java APIs may take 1-2 minutes to become Ready."
kubectl -n x1 get pods -o wide
