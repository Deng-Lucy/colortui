# colortui

Gives each terminal window its own text color, so you can tell them apart at a glance. Color is derived from the TTY path, so the same window always gets the same color.

## Install

```sh
git clone https://github.com/Deng-Lucy/colortui.git
cd colortui && sh install.sh
```

New terminals pick it up automatically. To apply to the current shell, run `source ~/.zshrc`.

## Uninstall

Delete the `# colortui` block from `~/.zshrc`.
