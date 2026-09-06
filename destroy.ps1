$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$tfDir = Join-Path $root "terraform"

Set-Location $tfDir
terraform destroy -auto-approve
