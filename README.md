# colortui

Gives each terminal window its own text color, so you can tell them apart at a glance. Color is derived from the session identity, so the same window always gets the same color.

## Install

**macOS / Linux (zsh/bash)**

```sh
git clone https://github.com/Deng-Lucy/colortui.git
cd colortui && sh install.sh
```

New terminals pick it up automatically. To apply to the current shell, run `source ~/.zshrc`.

**Windows (PowerShell)**

Works in Windows Terminal, VS Code terminal, and other xterm.js-based terminals. Does not work in the legacy Windows Console Host (conhost.exe).

```powershell
git clone https://github.com/Deng-Lucy/colortui.git
cd colortui; .\install.ps1
```

To apply to the current session: `. $PROFILE`

## Usage

Color is **on by default**. Enable or disable — the setting persists across all terminals:

**macOS / Linux**
```zsh
colortui-enable   # turn color on
colortui-disable  # turn color off
```

**Windows (PowerShell)**
```powershell
colortui-enable   # turn color on
colortui-disable  # turn color off
```

## Uninstall

**macOS / Linux**
```zsh
colortui-uninstall
```

**Windows (PowerShell)**
```powershell
colortui-uninstall
```

Then open a new terminal.
