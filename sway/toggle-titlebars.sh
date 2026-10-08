#!/bin/bash
# Toggle visibility of tab bars / titlebars in Sway / SwayFX (while staying in tabbed layout)

STATE_FILE="/tmp/sway_tabbars_hidden"

if [ -f "$STATE_FILE" ]; then
    # SHOW tab bar: switch window border to normal so window content moves down and doesn't overlap titlebar
    rm -f "$STATE_FILE"
    swaymsg '[title=".*"] border normal 2' >/dev/null 2>&1
    swaymsg 'font pango:DejaVu Sans Mono 11' >/dev/null 2>&1
    swaymsg 'titlebar_padding 6 4' >/dev/null 2>&1
    swaymsg 'titlebar_border_thickness 1' >/dev/null 2>&1
    swaymsg 'for_window [title=".*"] title_format "%title"' >/dev/null 2>&1
    swaymsg '[title=".*"] title_format "%title"' >/dev/null 2>&1
else
    # HIDE tab bar: switch window border to none and reload config to restore 3px minimal line
    touch "$STATE_FILE"
    swaymsg '[title=".*"] border none' >/dev/null 2>&1
    swaymsg reload >/dev/null 2>&1
fi
