function Test-Scenario {
    param(
        [string]$Scenario = "sc-01",
        [string]$Server = "nginx"
    )

    docker-compose `
        --ansi never `
        -f "docker-compose.yml" `
        -f "servers/$Server/docker-compose.yml" `
        --env-file "scenarios/$Scenario.env" `
        -p "$Server-$Scenario" `
        up --exit-code-from client `
        *> $result

    $exitCode = $LASTEXITCODE

    docker-compose `
        -p "$Server-$Scenario" `
        down `
        --volumes `
        --remove-orphans `
        *> $null

    if ($exitCode -eq 0) {
        return "Connection successful"
    }
    else {
        return "Connection failed"
    }
}

$scenarios = Get-ChildItem -Path "scenarios" -Filter "*.env" | ForEach-Object {
    $_.BaseName
}
$servers = Get-ChildItem -Path "servers" -Directory | ForEach-Object {
    $_.Name
}

$results = @{}

foreach ($server in $servers) {
    if (-not $results.ContainsKey($server)) {
        $results[$server] = @{}
    }

    foreach ($scenario in $scenarios) {
        Write-Host "Running scenario '$scenario' with server '$server'..."
        $results[$server][$scenario] = Test-Scenario -Scenario $scenario -Server $server
    }
}
 
New-Item -ItemType Directory `
        -Path (Join-Path $PSScriptRoot "results") `
        -Force | Out-Null
        
$results | 
    ConvertTo-Json -Depth 3 | 
    Out-File -FilePath "results/$((Get-Date).ToString('yyyyMMdd_HHmmss')).json" `
        -Encoding UTF8