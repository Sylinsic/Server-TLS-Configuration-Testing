param(
    [boolean]$ForceCheckAll = $false,
    [boolean]$CaptureOutput = $false,
    [int]$ParallelScenarios = 8
)

function Get-ServerHash() {
    param{
        [string]$server
    }

    $serverHashes = (Get-ChildItem -path $serverspath -file -recurse | sort-object FullName | foreach-object {
        (Get-FileHash -Path $_.FullName -Algorithm SHA256).Hash
    })

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($serverhashes -join "")
    $sha = [System.Security.Cryptography.SHA256]::HashData($bytes)

    return [Convert]::ToHexString($sha)
}

$scenariosPath = Join-Path $PSScriptRoot "scenarios"
$serversPath = Join-Path $PSScriptRoot "servers"

$serversKey = "servers"
$scenariosKey = "scenarios"

$lastResults = (Get-Content -Path "results/latest.json" | ConvertFrom-Json)

$scenarios = Get-ChildItem -Path $scenariosPath -Filter "*.env" | ForEach-Object {
    $_.BaseName
} | select-object -property `
    @{Name = "Name"; Expression = { $_ }},
    @{Name = "Hash"; Expression = { Get-FileHash (Join-Path $scenariosPath "${_}.env") | Select-Object -ExpandProperty Hash }}


$results = @{}
$results.$serversKey = @{}
$results.$scenariosKey = $scenarios

$servers = Get-ChildItem -Path $serversPath -Directory | ForEach-Object {
    $_.Name
} | select-object -property `
    @{Name = "Name"; Expression = { $_ }},
    @{Name = "Hash"; Expression = { Get-Serverhash -server $_ }}

$servers | foreach-object {
    $results.$serversKey.$($_.Name) = @{}
}


$serverResults = $servers | foreach-object {
    $server = $_

    $innerResults = $scenarios | foreach-object -throttlelimit $ParallelScenarios -parallel {
        $scenario = $_
        $server = $using:server
        
        if ($server.Hash -eq $lastResults.$serversKey.$($server.$Name).Hash -and
            $scenario.Hash -eq $lastResults.$scenariosKey.$($scenario.Name).Hash)
        {
            Write-Host "Skipping scenario '$($scenario.Name)' for server '$($server.Name)' (no changes detected). Copying results from previous run."
            return @{
                Scenario = $($scenario.Name)
                Result = $lastResults.$serversKey.$($server.Name).$($scenario.Name)
            }
        }

        function Test-Scenario {
            param(
                [string]$Scenario,
                [string]$Server
            )

            $result = $(docker-compose `
                --ansi never `
                -f "docker-compose.yml" `
                -f "servers/$Server/docker-compose.yml" `
                --env-file "scenarios/$Scenario.env" `
                -p "$($Server.ToLower())-$($Scenario.ToLower())" `
                up --exit-code-from client `
                2>&1) -split '`n'

            $exitCode = $LASTEXITCODE

            docker-compose `
                -p "$Server-$Scenario" `
                down `
                --volumes `
                --remove-orphans `
                *> $null

            if ($exitCode -eq 0) {
                return @{
                    Status = "Success"
                }
            }
            else {
                $output = @{
                    Status = "Failed"
                }

                if ($using:CaptureOutput) {
                    $output.Result = $result
                }

                return $output
            }
        }

        Write-Host "Running scenario '$($scenario.Name)' with server '$($server.Name)'..."
        
        return @{
            Scenario = $($scenario.Name)
            Result = Test-Scenario -Scenario $($scenario.Name) -Server $($server.Name)
        }
    }

    $innerResults | foreach-object {
        $res = $_

        $results.$serversKey.$($server.Name).$($res.Scenario) = $res.Result
    }
}
 
New-Item -ItemType Directory `
        -Path (Join-Path $PSScriptRoot "results") `
        -Force | Out-Null

$jsonOutput = $results | ConvertTo-Json -Depth 5
$jsonOutput | Out-File -FilePath "results/$((Get-Date).ToString('yyyyMMdd_HHmmss')).json" -Encoding UTF8
$jsonOutput | Out-File -FilePath "results/latest.json" -Encoding UTF8