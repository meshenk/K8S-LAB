param(
    [Parameter(Mandatory = $true)][string]$Names
)

$ErrorActionPreference = "Continue"
$deleter = Join-Path $PSScriptRoot "delete-instance.ps1"

foreach ($name in ($Names -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ })) {
    & $deleter -Name $name
}
exit 0
