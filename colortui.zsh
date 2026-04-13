# colortui.zsh
# Assigns a unique text color to each terminal session via OSC 10.
# Works in Terminal.app, VSCode, iTerm2, and most modern terminals.

claude() {
  local _tty _hash _idx
  _tty=$(tty 2>/dev/null || echo "tty$$")
  _hash=$(printf '%s' "$_tty" | cksum | awk '{print $1}')
  _idx=$((_hash % 8))

  local -a _fg=(
    "rgb:CC/44/44"
    "rgb:22/99/22"
    "rgb:99/88/00"
    "rgb:22/55/CC"
    "rgb:99/22/99"
    "rgb:00/88/88"
    "rgb:CC/77/00"
    "rgb:77/33/CC"
  )

  # Set foreground text color for the session
  printf '\033]10;%s\007' "${_fg[$((_idx + 1))]}"

  command claude "$@"
  local _ret=$?

  # Restore default foreground color on exit
  printf '\033]110;\007'

  return $_ret
}
