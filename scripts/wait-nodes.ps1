param(
    [Parameter(Mandatory = $true)][string]$Kubeconfig,
    [int]$ExpectedNodes = 3,
    [int]$TimeoutSec = 900
)

$ErrorActionPreference = "Stop"
$env:KUBECONFIG = $Kubeconfig

$kubectl = Get-Command kubectl -ErrorAction SilentlyContinue
if (-not $kubectl) {
    throw "kubectl was not found on PATH. Install Rancher Desktop or Kubernetes CLI tools first."
}

Write-Host "Waiting for $ExpectedNodes Ready node(s) using $Kubeconfig"
$deadline = (Get-Date).AddSeconds($TimeoutSec)

do {
    kubectl get nodes -o wide
    $jsonText = kubectl get nodes -o json 2>$null
    if ($LASTEXITCODE -eq 0 -and $jsonText) {
        $json = $jsonText | ConvertFrom-Json
        $ready = @($json.items | Where-Object {
                $_.status.conditions | Where-Object { $_.type -eq "Ready" -and $_.status -eq "True" }
            })
        Write-Host ("Ready {0}/{1}" -f $ready.Count, $ExpectedNodes)
        if ($ready.Count -ge $ExpectedNodes) {
            kubectl get nodes -o wide
            exit 0
        }
    }
    Start-Sleep -Seconds 10
} while ((Get-Date) -lt $deadline)

kubectl get nodes -o wide
throw "Timed out waiting for $ExpectedNodes Ready nodes."
