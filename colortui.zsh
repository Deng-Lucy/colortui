# colortui.zsh
# Assigns a unique text color to each terminal session via OSC 10.
# Works in Terminal.app, VSCode, iTerm2, and most modern terminals.

COLORTUI_ENABLED=${COLORTUI_ENABLED:-0}

colortui-enable()  { COLORTUI_ENABLED=1; echo "colortui: enabled"  }
colortui-disable() { COLORTUI_ENABLED=0; echo "colortui: disabled" }

claude() {
  local _tty _hash _idx
  _tty=$(tty 2>/dev/null || echo "tty$$")
  _hash=$(printf '%s' "$_tty" | cksum | awk '{print $1}')
  _idx=$((_hash % 14))

  local -a _fg=(
    "rgb:DD/99/33"
    "rgb:22/99/22"
    "rgb:99/88/00"
    "rgb:55/88/EE"
    "rgb:CC/66/CC"
    "rgb:00/88/88"
    "rgb:CC/77/00"
    "rgb:88/99/EE"
    "rgb:EE/EE/EE"
    "rgb:EE/AA/BB"
    "rgb:AA/DD/88"
    "rgb:EE/DD/66"
    "rgb:66/CC/EE"
    "rgb:CC/AA/EE"
  )

  if [[ "$COLORTUI_ENABLED" == "1" ]]; then
    # Set foreground text color for the session
    printf '\033]10;%s\007' "${_fg[$((_idx + 1))]}"
  fi

  command claude "$@"
  local _ret=$?

  if [[ "$COLORTUI_ENABLED" == "1" ]]; then
    # Restore default foreground color on exit
    printf '\033]110;\007'
  fi

  return $_ret
}
