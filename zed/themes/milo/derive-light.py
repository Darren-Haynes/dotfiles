#!/usr/bin/env python3
"""Derive "Milo Light" from the upstream dark Milo theme (hazicy/milo-theme-zed, MIT).

    derive-light.py [milo.json] [milo-light.json]

Upstream only ships a dark variant, so the light one is generated:

  * Surface neutrals (very dark greys: backgrounds, borders, element states)
    flip around the background, so "slightly raised" stays "slightly raised".
  * Everything else (text, syntax, accents, status colours) keeps its hue, gets
    a small saturation boost, and has its lightness solved so it reaches about
    the same contrast against the light background as the original has against
    the dark one.
  * White overlays (scrollbars, minimap) become black overlays.
  * Terminal black/white are chosen for readability on a light background.

Run once; the result is committed as milo-light.json and can be hand-tuned.
"""
import colorsys
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "milo.json")
DST = sys.argv[2] if len(sys.argv) > 2 else os.path.join(HERE, "milo-light.json")

DARK_BG = "#242424"
LIGHT_BG = "#f6f6f6"
SURFACE_LUM = 0.11   # below this relative luminance a neutral counts as a surface


def rgb(h):
    return tuple(int(h[i:i + 2], 16) / 255 for i in (1, 3, 5))


def hexs(c):
    return "#%02x%02x%02x" % tuple(max(0, min(255, round(v * 255))) for v in c)


def lum(c):
    def f(v):
        return v / 12.92 if v <= 0.03928 else ((v + 0.055) / 1.055) ** 2.4
    r, g, b = (f(v) for v in c)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def with_lum(c, target):
    """Keep hue and HSV saturation, find the value that gives relative luminance `target`.

    HSV keeps a faint tint faint (HLS would inflate it as lightness drops)."""
    h, sat, _ = colorsys.rgb_to_hsv(*c)
    lo, hi = 0.0, 1.0
    for _ in range(40):
        mid = (lo + hi) / 2
        if lum(colorsys.hsv_to_rgb(h, sat, mid)) < target:
            lo = mid
        else:
            hi = mid
    return colorsys.hsv_to_rgb(h, sat, (lo + hi) / 2)


DARK_L = lum(rgb(DARK_BG))
LIGHT_L = lum(rgb(LIGHT_BG))


def contrast(a, b):
    hi, lo = max(a, b), min(a, b)
    return (hi + 0.05) / (lo + 0.05)


def convert(color):
    """Convert one dark-theme colour (#rrggbb or #rrggbbaa) to its light-theme counterpart."""
    base, alpha = color[:7], color[7:]
    c = rgb(base)
    h, l, s = colorsys.rgb_to_hls(*c)
    cl = lum(c)

    if base.lower() == "#ffffff" and alpha:          # white overlays -> black overlays
        return "#000000" + alpha
    if cl < SURFACE_LUM:                              # surface neutral: flip around the background
        l_bg = colorsys.rgb_to_hls(*rgb(DARK_BG))[1]
        l_bg_light = colorsys.rgb_to_hls(*rgb(LIGHT_BG))[1]
        nl = max(0.0, min(1.0, l_bg_light - (l - l_bg) * 1.15))
        return hexs(colorsys.hls_to_rgb(h, nl, s)) + alpha

    cr = contrast(cl, DARK_L)
    hh, sat, vv = colorsys.rgb_to_hsv(*c)
    if sat < 0.14:                                    # neutral foreground (text, icons, comments)
        target_cr = 1 + (cr - 1) * 0.9
    else:                                             # hued colour (syntax, accents, status)
        target_cr = max(4.4, 1 + (cr - 1) * 0.62)
        c = colorsys.hsv_to_rgb(hh, min(0.82, sat * 1.5 + 0.10), vv)
    target_lum = max(0.0, (LIGHT_L + 0.05) / target_cr - 0.05)
    return hexs(with_lum(c, target_lum)) + alpha


def walk(node, path, fn):
    if isinstance(node, dict):
        return {k: walk(v, path + [k], fn) for k, v in node.items()}
    if isinstance(node, list):
        return [walk(v, path + [str(i)], fn) for i, v in enumerate(node)]
    return fn(".".join(path), node)


# Terminal colours that need readability-driven choices rather than a straight
# conversion (light-on-light "white" would be invisible).
def terminal_override(path, value, dark):
    def solve(src, cr):
        return hexs(with_lum(rgb(src), (LIGHT_L + 0.05) / cr - 0.05))

    table = {
        "terminal.ansi.black": convert(dark["text"]),
        "terminal.ansi.white": solve("#6b7078", 5.0),
        "terminal.ansi.bright_black": solve("#686e76", 4.6),
        "terminal.ansi.bright_white": solve("#4a4f56", 8.0),
        "terminal.bright_foreground": solve("#2a2c30", 14.0),
        "terminal.dim_foreground": solve("#767d86", 4.0),
    }
    return table.get(path, None)


def main():
    src = json.load(open(SRC))
    dark = src["themes"][0]
    style = dark["style"]

    def fn(path, value):
        if not (isinstance(value, str) and re.fullmatch(r"#[0-9a-fA-F]{6}([0-9a-fA-F]{2})?", value)):
            return value
        override = terminal_override(path, value, style)
        return override if override else convert(value)

    light_style = walk(style, [], fn)
    # Window chrome backgrounds all sit on the page background, like upstream.
    for key in ("background", "surface.background", "panel.background", "title_bar.background",
                "status_bar.background", "toolbar.background", "tab_bar.background",
                "tab.inactive_background", "editor.background", "editor.gutter.background",
                "terminal.background", "panel.overlay_background", "panel.overlay_hover"):
        if key in light_style:
            light_style[key] = LIGHT_BG

    out = {
        "$schema": src["$schema"],
        "name": "Milo Light",
        "author": "derived from Milo by hazicy (MIT)",
        "themes": [{"name": "Milo Light", "appearance": "light", "style": light_style}],
    }
    with open(DST, "w") as f:
        json.dump(out, f, indent=2)
        f.write("\n")
    print("wrote", DST)


if __name__ == "__main__":
    main()
