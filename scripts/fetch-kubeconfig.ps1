param(
    [Parameter(Mandatory = $true)][string]$ServerName,
    [Parameter(Mandatory = $true)][string]$ServerIP,
    [Parameter(Mandatory = $true)][string]$OutFile
)

$ErrorActionPreference = "Stop"

Write-Host "Fetching kubeconfig from $ServerName and pointing the API server at https://${ServerIP}:6443"

$lines = & multipass exec $ServerName -- sudo cat /etc/rancher/rke2/rke2.yaml
if ($LASTEXITCODE -ne 0) {
    throw "Failed to read /etc/rancher/rke2/rke2.yaml from $ServerName"
}

$text = ($lines | Out-String).Trim()
if ([string]::IsNullOrWhiteSpace($text)) {
    throw "kubeconfig from $ServerName was empty"
}

$text = $text -replace "https://127\.0\.0\.1:6443", "https://${ServerIP}:6443"
$text = $text -replace "https://localhost:6443", "https://${ServerIP}:6443"

$directory = Split-Path -Parent $OutFile
if ($directory -and -not (Test-Path -LiteralPath $directory)) {
    New-Item -ItemType Directory -Path $directory | Out-Null
}

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($OutFile, $text + "`n", $utf8NoBom)
Write-Host "Wrote $OutFile"
