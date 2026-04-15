#!/usr/bin/env pwsh
# install.ps1 — Windows PowerShell installer for colortui

$ErrorActionPreference = 'Stop'

$REPO_URL = "https://raw.githubusercontent.com/Deng-Lucy/colortui/main/colortui.ps1"
$MARKER = "# colortui: per-terminal text color"

# Detect PowerShell profile path
$RC = $PROFILE
if (-not $RC) {
    $RC = Join-Path ([Environment]::GetFolderPath('MyDocuments')) "PowerShell\Microsoft.PowerShell_profile.ps1"
}

# Check if already installed
if ((Test-Path $RC) -and (Select-String -Path $RC -Pattern ([regex]::Escape($MARKER)) -Quiet)) {
    Write-Host "colortui is already installed in $RC"
    exit 0
}

# Ensure profile directory exists
$rcDir = Split-Path $RC
if (-not (Test-Path $rcDir)) {
    New-Item -ItemType Directory -Force -Path $rcDir | Out-Null
}

# Download or source locally
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -ErrorAction SilentlyContinue
$localSrc = if ($scriptDir) { Join-Path $scriptDir "colortui.ps1" } else { $null }

if ($localSrc -and (Test-Path $localSrc)) {
    $content = Get-Content $localSrc -Raw
} else {
    Write-Host "Downloading colortui.ps1..."
    $content = (Invoke-WebRequest -Uri $REPO_URL -UseBasicParsing).Content
}

# Append to PowerShell profile
Add-Content -Path $RC -Value "`n$MARKER`n$content"

# Enable by default (persistent state file)
$state = if ($env:XDG_CONFIG_HOME) {
    Join-Path $env:XDG_CONFIG_HOME "colortui\enabled"
} else {
    Join-Path $env:APPDATA "colortui\enabled"
}
$stateDir = Split-Path $state
New-Item -ItemType Directory -Force -Path $stateDir | Out-Null
New-Item -ItemType File -Force -Path $state | Out-Null

Write-Host "Installed and enabled! To apply now, run:"
Write-Host "  . `$PROFILE"
