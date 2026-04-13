# colortui

Gives each terminal window its own text color, so you can tell them apart at a glance. Color is derived from the TTY path, so the same window always gets the same color.

## Install

```sh
git clone https://github.com/Deng-Lucy/colortui.git
cd colortui && sh install.sh
```

New terminals pick it up automatically. To apply to the current shell, run `source ~/.zshrc`.

## Usage

Color is **off by default**. Enable it for the current session:

```zsh
colortui-enable   # turn color on
colortui-disable  # turn color off
```

## Uninstall

```zsh
colortui-uninstall
```

Then open a new terminal.
