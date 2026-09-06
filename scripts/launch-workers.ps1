param(
    [Parameter(Mandatory = $true)][string]$Names,
    [Parameter(Mandatory = $true)][string]$Image,
    [Parameter(Mandatory = $true)][int]$Cpus,
    [Parameter(Mandatory = $true)][string]$Memory,
    [Parameter(Mandatory = $true)][string]$Disk,
    [Parameter(Mandatory = $true)][string]$GeneratedDir,
    [int]$TimeoutSec = 2700
)

$ErrorActionPreference = "Stop"
$launcher = Join-Path $PSScriptRoot "launch-instance.ps1"

foreach ($name in ($Names -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ })) {
    $cloudInit = Join-Path $GeneratedDir "$name-cloud-init.yaml"
    if (-not (Test-Path -LiteralPath $cloudInit)) {
        throw "Missing cloud-init file $cloudInit"
    }
    & $launcher -Name $name -Image $Image -Cpus $Cpus -Memory $Memory -Disk $Disk -CloudInit $cloudInit -TimeoutSec $TimeoutSec
}
