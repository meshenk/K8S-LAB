$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

$queryJson = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($queryJson)) {
    throw "terraform external query was empty"
}

$query = $queryJson | ConvertFrom-Json
$name = [string]$query.name
if ([string]::IsNullOrWhiteSpace($name)) {
    throw "query.name is required"
}

$raw = & multipass info $name --format json
if ($LASTEXITCODE -ne 0) {
    throw "multipass info $name failed"
}

$info = $raw | ConvertFrom-Json
$node = $info.info.PSObject.Properties[$name].Value
if ($null -eq $node) {
    throw "instance $name not found in multipass info"
}

$ip = @($node.ipv4 | Where-Object { $_ -notlike "127.*" })[0]
if ([string]::IsNullOrWhiteSpace($ip)) {
    throw "instance $name has no IPv4 address yet"
}

$result = @{
    ip    = [string]$ip
    state = [string]$node.state
}
[Console]::Out.Write(($result | ConvertTo-Json -Compress))
