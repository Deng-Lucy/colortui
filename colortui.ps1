# colortui.ps1
# Assigns a unique text color to each terminal session via OSC 10.
# Works in Windows Terminal, VS Code terminal, and other xterm.js-based terminals.

$_COLORTUI_STATE = if ($env:XDG_CONFIG_HOME) {
    Join-Path $env:XDG_CONFIG_HOME "colortui\enabled"
} else {
    Join-Path $env:APPDATA "colortui\enabled"
}

function _colortui_is_enabled { Test-Path $_COLORTUI_STATE }

function colortui-enable {
    $dir = Split-Path $_COLORTUI_STATE
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    New-Item -ItemType File -Force -Path $_COLORTUI_STATE | Out-Null
    Write-Host "colortui: enabled (persists across terminals)"
}

function colortui-disable {
    Remove-Item -Force -ErrorAction SilentlyContinue $_COLORTUI_STATE
    Write-Host "colortui: disabled"
}

function colortui-uninstall {
    $profile_path = $PROFILE
    if (Test-Path $profile_path) {
        $content = Get-Content $profile_path -Raw
        $content = $content -replace '(?s)\r?\n# colortui: per-terminal text color\r?\n.*?\r?\n# end colortui\r?\n', "`n"
        Set-Content $profile_path $content -NoNewline
    }
    Remove-Item -Force -ErrorAction SilentlyContinue $_COLORTUI_STATE
    Write-Host "colortui: removed from $profile_path — open a new terminal to finish"
}

function claude {
    $colors = @(
        "rgb:DD/99/33"
        "rgb:22/99/22"
        "rgb:DD/77/55"
        "rgb:88/EE/CC"
        "rgb:CC/66/CC"
        "rgb:EE/BB/88"
        "rgb:88/99/EE"
        "rgb:EE/EE/EE"
        "rgb:EE/AA/BB"
        "rgb:AA/DD/88"
        "rgb:EE/DD/66"
        "rgb:66/CC/EE"
        "rgb:CC/AA/EE"
    )

    # Use WT_SESSION (Windows Terminal tab GUID) if available, else fall back to PID
    $sessionId = if ($env:WT_SESSION) { $env:WT_SESSION } else { "$PID" }
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($sessionId)
    $hash = [uint32]0
    foreach ($b in $bytes) { $hash = $hash * 31 + $b }
    $idx = $hash % 13

    if (_colortui_is_enabled) {
        [Console]::Write("`e]10;$($colors[$idx])`a")
    }

    $claudeCmd = Get-Command claude -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $claudeCmd) {
        Write-Error "colortui: 'claude' executable not found in PATH"
        return 1
    }
    & $claudeCmd @args
    $ret = $LASTEXITCODE

    if (_colortui_is_enabled) {
        [Console]::Write("`e]110;`a")
    }

    return $ret
}
# end colortui
