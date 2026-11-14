
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
    "Tier2CA1",
    "Tier3CA1",
    "Tier3CA2",
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
$Tier2CA1 = "$OutputDirectory\Tier2CA1"
$Tier3CA1 = "$OutputDirectory\Tier3CA1"
$Tier3CA2 = "$OutputDirectory\Tier3CA2"
$Server = "$OutputDirectory\Server"
$Client = "$OutputDirectory\Client"
$Chains = "$OutputDirectory\Chains"

Write-Host "`n=== FOUR TIER PKI CREATION ===" -ForegroundColor Cyan

# --------------------------------------------------
# TIER 1: ROOT CA
# --------------------------------------------------

Write-Host "`n[1/6] Generating Root CA..." -ForegroundColor Yellow

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
# TIER 2: Tier 2 INTERMEDIATE CA 1
# --------------------------------------------------

Write-Host "`n[2/6] Generating Tier 2 Intermediate CA 1..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:3072",
    "-out", "$Tier2CA1\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Tier2CA1\cert.key",
    "-out", "$Tier2CA1\cert.csr",
    "-subj", "/CN=Lab Tier 1 Intermediate CA 1/O=Example PKI"
)

$Tier2CA1Config = @'
[v3_intermediate_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
'@

$Tier2CA1Config | Set-Content "$Tier2CA1\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Tier2CA1\cert.csr",
    "-CA", "$Root\cert.crt",
    "-CAkey", "$Root\cert.key",
    "-CAcreateserial",
    "-out", "$Tier2CA1\cert.crt",
    "-days", "$IntermediateDays",
    "-sha256",
    "-extfile", "$Tier2CA1\cert.cnf",
    "-extensions", "v3_intermediate_ca"
)

Write-Host "Tier 2 Intermediate CA 1 created." -ForegroundColor Green

# --------------------------------------------------
# TIER 3: Tier 3 INTERMEDIATE CA 1
# --------------------------------------------------

Write-Host "`n[3/6] Generating Tier 3 Intermediate CA 1..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:3072",
    "-out", "$Tier3CA1\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Tier3CA1\cert.key",
    "-out", "$Tier3CA1\cert.csr",
    "-subj", "/CN=Lab Tier 3 Intermediate CA 1/O=Example PKI"
)

$Tier3CA1Config = @'
[v3_intermediate_ca]
basicConstraints = critical,CA:TRUE,pathlen:0
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
'@

$Tier3CA1Config | Set-Content "$Tier3CA1\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Tier3CA1\cert.csr",
    "-CA", "$Tier2CA1\cert.crt",
    "-CAkey", "$Tier2CA1\cert.key",
    "-CAcreateserial",
    "-out", "$Tier3CA1\cert.crt",
    "-days", "$IntermediateDays",
    "-sha256",
    "-extfile", "$Tier3CA1\cert.cnf",
    "-extensions", "v3_intermediate_ca"
)

Write-Host "Tier 3 Intermediate CA 1 created." -ForegroundColor Green

# --------------------------------------------------
# TIER 3: Tier 3 INTERMEDIATE CA 2
# --------------------------------------------------

Write-Host "`n[4/6] Generating Tier 3 Intermediate CA 2..." -ForegroundColor Yellow

Invoke-OpenSSL @(
    "genpkey", "-algorithm", "RSA",
    "-pkeyopt", "rsa_keygen_bits:3072",
    "-out", "$Tier3CA2\cert.key"
)

Invoke-OpenSSL @(
    "req", "-new",
    "-key", "$Tier3CA2\cert.key",
    "-out", "$Tier3CA2\cert.csr",
    "-subj", "/CN=Lab Tier 3 Intermediate CA 2/O=Example PKI"
)

$Tier3CA2Config = @'
[v3_intermediate_ca]
basicConstraints = critical,CA:TRUE,pathlen:0
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
'@

$Tier3CA2Config | Set-Content "$Tier3CA2\cert.cnf" -Encoding ASCII

Invoke-OpenSSL @(
    "x509", "-req",
    "-in", "$Tier3CA2\cert.csr",
    "-CA", "$Tier2CA1\cert.crt",
    "-CAkey", "$Tier2CA1\cert.key",
    "-CAcreateserial",
    "-out", "$Tier3CA2\cert.crt",
    "-days", "$IntermediateDays",
    "-sha256",
    "-extfile", "$Tier3CA2\cert.cnf",
    "-extensions", "v3_intermediate_ca"
)

Write-Host "Tier 3 Intermediate CA 2 created." -ForegroundColor Green


# --------------------------------------------------
# TIER 4: SERVER CERTIFICATE
# --------------------------------------------------

Write-Host "`n[5/6] Generating Server Certificate..." -ForegroundColor Yellow

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
    "-CA", "$Tier3CA1\cert.crt",
    "-CAkey", "$Tier3CA1\cert.key",
    "-CAcreateserial",
    "-out", "$Server\cert.crt",
    "-days", "$EndEntityDays",
    "-sha256",
    "-extfile", "$Server\cert.cnf",
    "-extensions", "v3_end_entity"
)

Write-Host "Server Certificate created." -ForegroundColor Green


# --------------------------------------------------
# TIER 4: CLIENT CERTIFICATE
# --------------------------------------------------

Write-Host "`n[6/6] Generating Client Certificate..." -ForegroundColor Yellow

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
    "-CA", "$Tier3CA1\cert.crt",
    "-CAkey", "$Tier3CA1\cert.key",
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
$Tier2CA1Cert = Get-Content "$Tier2CA1\cert.crt" -Raw
$Tier3CA1Cert = Get-Content "$Tier3CA1\cert.crt" -Raw
$ServerCert = Get-Content "$Server\cert.crt" -Raw
$ClientCert = Get-Content "$Client\cert.crt" -Raw

[System.IO.File]::WriteAllText(
    "$Server\Chains\full.crt",
    $ServerCert + $Tier3CA1Cert + $Tier2CA1Cert + $rootCert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Server\Chains\intermediates.crt",
    $ServerCert + $Tier3CA1Cert + $Tier2CA1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Server\Chains\issuer.crt",
    $ServerCert + $Tier3CA1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Client\Chains\full.crt",
    $ClientCert + $Tier3CA1Cert + $Tier2CA1Cert + $rootCert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Client\Chains\intermediates.crt",
    $ClientCert + $Tier3CA1Cert + $Tier2CA1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Client\Chains\issuer.crt",
    $ClientCert + $Tier3CA1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Chains\full.crt",
    $Tier3CA1Cert + $Tier2CA1Cert + $rootCert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Chains\intermediates.crt",
    $Tier3CA1Cert + $Tier2CA1Cert,
    [System.Text.Encoding]::ASCII
)

[System.IO.File]::WriteAllText(
    "$Chains\issuer.crt",
    $Tier3CA1Cert,
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
    "x509", "-in", "$Tier2CA1\cert.crt",
    "-noout", "-subject", "-issuer"
)

Write-Host "`nIntermediate CA 2:"
Invoke-OpenSSL @(
    "x509", "-in", "$Tier3CA1\cert.crt",
    "-noout", "-subject", "-issuer"
)

Write-Host "`nEnd Entity:"
Invoke-OpenSSL @(
    "x509", "-in", "$Server\cert.crt",
    "-noout", "-subject", "-issuer", "-dates"
)

Write-Host "`nOutput directory: $OutputDirectory" -ForegroundColor Cyan
