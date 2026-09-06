param(
    [Parameter(Mandatory = $true)][string]$Name
)

$ErrorActionPreference = "Continue"
Write-Host "Deleting Multipass instance $Name"
& multipass delete --purge $Name
if ($LASTEXITCODE -ne 0) {
    Write-Host "Instance $Name was already absent (ignored)"
}
exit 0
