$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$tfDir = Join-Path $root "terraform"

function Assert-Command($name) {
    if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
        throw "$name was not found on PATH."
    }
}

Assert-Command terraform
Assert-Command multipass

Write-Host "Initializing Terraform in $tfDir"
Set-Location $tfDir
New-Item -ItemType Directory -Force -Path (Join-Path $tfDir "generated") | Out-Null
terraform init -upgrade
terraform apply -auto-approve -parallelism=1

Write-Host ""
Write-Host "Cluster apply finished. Next:"
Write-Host "  `$env:KUBECONFIG = '$(Join-Path $root 'kubeconfig.yaml')'"
Write-Host "  kubectl get nodes -o wide"
