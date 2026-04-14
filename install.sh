#!/bin/sh
set -e

REPO_URL="https://raw.githubusercontent.com/Deng-Lucy/colortui/main/colortui.zsh"
MARKER="# colortui: per-terminal text color"

# Detect shell config file
if [ -n "$ZSH_VERSION" ] || [ "$(basename "$SHELL")" = "zsh" ]; then
  RC="$HOME/.zshrc"
else
  RC="$HOME/.bashrc"
fi

# Check if already installed
if grep -qF "$MARKER" "$RC" 2>/dev/null; then
  echo "colortui is already installed in $RC"
  exit 0
fi

# Download or source locally
if [ -f "$(dirname "$0")/colortui.zsh" ]; then
  # Running from a local clone
  SRC="$(dirname "$0")/colortui.zsh"
  CONTENT=$(cat "$SRC")
else
  # Running via curl | sh
  CONTENT=$(curl -fsSL "$REPO_URL")
fi

# Append to shell config
printf '\n%s\n%s\n' "$MARKER" "$CONTENT" >> "$RC"
# (end marker is embedded in colortui.zsh itself)

# Enable by default (persistent state file)
_state="${XDG_CONFIG_HOME:-$HOME/.config}/colortui/enabled"
mkdir -p "$(dirname "$_state")"
touch "$_state"

echo "Installed and enabled! To apply now, run:"
echo "  source $RC"
