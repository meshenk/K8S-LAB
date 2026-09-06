param(
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][string]$Image,
    [Parameter(Mandatory = $true)][int]$Cpus,
    [Parameter(Mandatory = $true)][string]$Memory,
    [Parameter(Mandatory = $true)][string]$Disk,
    [Parameter(Mandatory = $true)][string]$CloudInit,
    [int]$TimeoutSec = 2700
)

$ErrorActionPreference = "Stop"

function Get-MultipassNode([string]$NodeName) {
    $raw = & multipass list --format json
    if ($LASTEXITCODE -ne 0) {
        throw "multipass list failed"
    }
    $list = $raw | ConvertFrom-Json
    return @($list.list | Where-Object { $_.name -eq $NodeName })[0]
}

$node = Get-MultipassNode $Name
if ($null -ne $node -and $node.state -eq "Deleted") {
    Write-Host "Purging leftover deleted instance $Name"
    & multipass delete --purge $Name
    $node = $null
}

if ($null -ne $node) {
    Write-Host "Checking whether $Name already finished RKE2 bootstrap"
    & multipass exec $Name -- test -f /var/log/rke2-bootstrap.done
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Instance $Name exists but bootstrap is incomplete; recreating it"
        & multipass delete --purge $Name
        if ($LASTEXITCODE -ne 0) {
            throw "failed to delete incomplete instance $Name"
        }
        $node = $null
    }
}

if ($null -eq $node) {
    Write-Host "Launching $Name ($Image, $Cpus CPU, $Memory, $Disk)"
    & multipass launch $Image --name $Name --cpus $Cpus --memory $Memory --disk $Disk --cloud-init $CloudInit --timeout $TimeoutSec
    if ($LASTEXITCODE -ne 0) {
        throw "multipass launch $Name failed"
    }
}
elseif ($node.state -ne "Running") {
    Write-Host "Starting existing instance $Name (state=$($node.state))"
    & multipass start $Name
    if ($LASTEXITCODE -ne 0) {
        throw "multipass start $Name failed"
    }
}
else {
    Write-Host "Instance $Name already running"
}

Write-Host "Waiting for cloud-init on $Name"
& multipass exec $Name -- sudo cloud-init status --wait
if ($LASTEXITCODE -ne 0) {
    Write-Host "cloud-init status --wait exited $LASTEXITCODE (bootstrap log will be checked next)"
}
$cloudInitStatus = (& multipass exec $Name -- cloud-init status) | Out-String
Write-Host $cloudInitStatus.Trim()

Write-Host "Waiting for RKE2 bootstrap marker on $Name"
$deadline = (Get-Date).AddSeconds($TimeoutSec)
do {
    & multipass exec $Name -- test -f /var/log/rke2-bootstrap.done
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Bootstrap complete on $Name"
        & multipass info $Name
        exit 0
    }
    Start-Sleep -Seconds 10
} while ((Get-Date) -lt $deadline)

Write-Host "Bootstrap timed out on $Name. Last log lines:"
& multipass exec $Name -- sudo tail -n 120 /var/log/rke2-bootstrap.log
throw "RKE2 bootstrap did not finish on $Name"
