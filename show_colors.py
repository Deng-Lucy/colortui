#!/usr/bin/env python3
"""Display all colortui palette colors using ANSI truecolor."""

COLORS = [
    "rgb:DD/99/33",
    "rgb:22/99/22",
    "rgb:DD/77/55",
    "rgb:88/EE/CC",
    "rgb:CC/66/CC",
    "rgb:EE/BB/88",
    "rgb:88/99/EE",
    "rgb:EE/EE/EE",
    "rgb:EE/AA/BB",
    "rgb:AA/DD/88",
    "rgb:EE/DD/66",
    "rgb:66/CC/EE",
    "rgb:CC/AA/EE",
]

SAMPLE = "  Claude Code — ttys{:03d}  "
RESET = "\033[0m"

def parse(color):
    _, rest = color.split(":")
    r, g, b = rest.split("/")
    return int(r, 16), int(g, 16), int(b, 16)

def fg(r, g, b):
    return f"\033[38;2;{r};{g};{b}m"

def bg(r, g, b):
    # dim dark background so light colors are visible
    return f"\033[48;2;30;30;30m"

for i, c in enumerate(COLORS):
    r, g, b = parse(c)
    text = SAMPLE.format(i)
    print(f"{bg(r,g,b)}{fg(r,g,b)}{text}{RESET}  #{i:02d}  {c}  rgb({r},{g},{b})")
