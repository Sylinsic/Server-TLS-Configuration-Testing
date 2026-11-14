
#requires -Version 5.1

param(
    [string]$OutputDirectory = $PSScriptRoot,
    [string]$DnsName = "server"
)

$ErrorActionPreference = "Stop"

# Certificate validity
$RootDays = 3650
$IntermediateDays = 1825
$EndEntityDays = 365
$OpenSSLPath = "C:\Program Files\OpenSSL Library\openssl-4.1\bin\openssl.exe"

# Check OpenSSL
if (-not (Get-Command $OpenSSLPath -ErrorAction SilentlyContinue)) {
    throw "OpenSSL not found. Install OpenSSL and add it to PATH."
}

# Create directory structure
$Directories = @(
    "RootCA",
    "IntermediateCA1",
    "IntermediateCA2",
    "Server",
    "Server\Chains",
    "Client",
    "Client\Chains",
    "Chains"
)

foreach ($Directory in $Directories) {
    New-Item -ItemType Directory `
        -Path (Join-Path $OutputDirectory $Directory) `
        -Force | Out-Null
}

# OpenSSL wrapper
function Invoke-OpenSSL {
    param([string[]]$Arguments)

    & $OpenSSLPath @Arguments

    if ($LASTEXITCODE -ne 0) {
        throw "OpenSSL command failed: $($Arguments -join ' ')"
    }
}

# File paths
$Root = "$OutputDirectory\RootCA"
$Int1 = "$OutputDirectory\IntermediateCA1"
$Int2 = "$OutputDirectory\IntermediateCA2"
$Server = "$OutputDirectory\Server"
$Client = "$OutputDirectory\Client"
$Chains = "$OutputDirectory\Chains"

Write-Host "`n=== FOUR TIER PKI CREATION ===" -ForegroundColor Cyan

# --------------------------------------------------
# TIER 1: ROOT CA
# --------------------------------------------------

Write-Host "`n[1/5] Generating Root CA..." -ForegroundColor Yellow

$RootConfig = @'
[req]
distinguished_name = dn
prompt = no
x509_extensions = v3_ca

[dn]
CN = Lab Root CA
O = Example PKI

[v3_ca]
basicConstraints = critical,CA:TRUE,pathlen:2
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
'@

$RootConfig | Set-Content "$Root\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "req", "-x509", "-newkey", "rsa:4096",
    "-nodes",
    "-keyout", "$Root\cert.key",
    "-out", "$Root\cert.crt",
    "-days", "$RootDays",
    "-sha256",
    "-config", "$Root\cert.cnf",
    "-extensions", "v3_ca"
)

Write-Host "Root CA created." -ForegroundColor Green

# --------------------------------------------------
# TIER 2: INTERMEDIATE CA 1
# --------------------------------------------------

Write-Host "`n[2/5] Generating Intermediate CA 1..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:3072",
    "-out", "$Int1\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Int1\cert.key",
    "-out", "$Int1\cert.csr",
    "-subj", "/CN=Lab Intermediate CA 1/O=Example PKI"
)

$Int1Config = @'
[v3_intermediate_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
'@

$Int1Config | Set-Content "$Int1\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Int1\cert.csr",
    "-CA", "$Root\cert.crt",
    "-CAkey", "$Root\cert.key",
    "-CAcreateserial",
    "-out", "$Int1\cert.crt",
    "-days", "$IntermediateDays",
    "-sha256",
    "-extfile", "$Int1\cert.cnf",
    "-extensions", "v3_intermediate_ca"
)

Write-Host "Intermediate CA 1 created." -ForegroundColor Green

# --------------------------------------------------
# TIER 3: INTERMEDIATE CA 2
# --------------------------------------------------

Write-Host "`n[3/5] Generating Intermediate CA 2..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:3072",
    "-out", "$Int2\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Int2\cert.key",
    "-out", "$Int2\cert.csr",
    "-subj", "/CN=Lab Intermediate CA 2/O=Example PKI"
)

$Int2Config = @'
[v3_intermediate_ca]
basicConstraints = critical,CA:TRUE,pathlen:0
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
'@

$Int2Config | Set-Content "$Int2\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Int2\cert.csr",
    "-CA", "$Int1\cert.crt",
    "-CAkey", "$Int1\cert.key",
    "-CAcreateserial",
    "-out", "$Int2\cert.crt",
    "-days", "$IntermediateDays",
    "-sha256",
    "-extfile", "$Int2\cert.cnf",
    "-extensions", "v3_intermediate_ca"
)

Write-Host "Intermediate CA 2 created." -ForegroundColor Green

# --------------------------------------------------
# TIER 4: SERVER CERTIFICATE
# --------------------------------------------------

Write-Host "`n[4/5] Generating Server Certificate..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:2048",
    "-out", "$Server\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Server\cert.key",
    "-out", "$Server\cert.csr",
    "-subj", "/CN=$DnsName/O=Example PKI"
)

$ServerConfig = @"
[v3_end_entity]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
subjectAltName = DNS:$DnsName
"@

$ServerConfig | Set-Content "$Server\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Server\cert.csr",
    "-CA", "$Int2\cert.crt",
    "-CAkey", "$Int2\cert.key",
    "-CAcreateserial",
    "-out", "$Server\cert.crt",
    "-days", "$EndEntityDays",
    "-sha256",
    "-extfile", "$Server\cert.cnf",
    "-extensions", "v3_end_entity"
)

Write-Host "Server Certificate created." -ForegroundColor Green


# --------------------------------------------------
# TIER 5: CLIENT CERTIFICATE
# --------------------------------------------------

Write-Host "`n[5/5] Generating Client Certificate..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:2048",
    "-out", "$Client\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Client\cert.key",
    "-out", "$Client\cert.csr",
    "-subj", "/CN=My Client/O=Example PKI"
)

$ClientConfig = @"
[v3_end_entity]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = clientAuth
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
"@

$ClientConfig | Set-Content "$Client\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Client\cert.csr",
    "-CA", "$Int2\cert.crt",
    "-CAkey", "$Int2\cert.key",
    "-CAcreateserial",
    "-out", "$Client\cert.crt",
    "-days", "$EndEntityDays",
    "-sha256",
    "-extfile", "$Client\cert.cnf",
    "-extensions", "v3_end_entity"
)

Write-Host "Client Certificate created." -ForegroundColor Green


# --------------------------------------------------
# CREATE CERTIFICATE CHAIN
# --------------------------------------------------

Write-Host "`nCreating certificate chain..." -ForegroundColor Yellow

$rootCert = Get-Content "$Root\cert.crt" -Raw
$Int1Cert = Get-Content "$Int1\cert.crt" -Raw
$Int2Cert = Get-Content "$Int2\cert.crt" -Raw
$ServerCert = Get-Content "$Server\cert.crt" -Raw
$ClientCert = Get-Content "$Client\cert.crt" -Raw

[System.IO.File]::WriteAllText(
    "$Server\Chains\full.crt",
    $ServerCert + $Int2Cert + $Int1Cert + $rootCert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Server\Chains\intermediates.crt",
    $ServerCert + $Int2Cert + $Int1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Server\Chains\issuer.crt",
    $ServerCert + $Int2Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Client\Chains\full.crt",
    $ClientCert + $Int2Cert + $Int1Cert + $rootCert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Client\Chains\intermediates.crt",
    $ClientCert + $Int2Cert + $Int1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Client\Chains\issuer.crt",
    $ClientCert + $Int2Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Chains\full.crt",
    $Int2Cert + $Int1Cert + $rootCert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Chains\intermediates.crt",
    $Int2Cert + $Int1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Chains\issuer.crt",
    $Int2Cert,
    [System.Text.Encoding]::ASCII
)

# --------------------------------------------------
# VERIFY CERTIFICATE CHAIN
# --------------------------------------------------

Write-Host "`nVerifying certificate chain..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "verify",
    "-CAfile", "$Root\cert.crt",
    "-untrusted", "$Chains\intermediates.crt",
    "$Server\cert.crt"
)

# --------------------------------------------------
# DISPLAY CERTIFICATES
# --------------------------------------------------

Write-Host "`n=== PKI SUCCESSFULLY CREATED ===" -ForegroundColor Green

Write-Host "Root CA:"
Invoke-OpenSSL @(
    "x509", "-in", "$Root\cert.crt",
    "-noout", "-subject", "-issuer", "-dates"
)

Write-Host "`nIntermediate CA 1:"
Invoke-OpenSSL @(
    "x509", "-in", "$Int1\cert.crt",
    "-noout", "-subject", "-issuer"
)

Write-Host "`nIntermediate CA 2:"
Invoke-OpenSSL @(
    "x509", "-in", "$Int2\cert.crt",
    "-noout", "-subject", "-issuer"
)

Write-Host "`nEnd Entity:"
Invoke-OpenSSL @(
    "x509", "-in", "$Server\cert.crt",
    "-noout", "-subject", "-issuer", "-dates"
)

Write-Host "`nOutput directory: $OutputDirectory" -ForegroundColor Cyan
