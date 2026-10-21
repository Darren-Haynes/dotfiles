#!/bin/sh
STATE_FILE="/tmp/sway-gaps-state"

if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "on" ]; then
    swaymsg gaps inner all set 0
    swaymsg gaps outer all set 0
    echo "off" > "$STATE_FILE"
else
    swaymsg gaps inner all set 10
    swaymsg gaps outer all set 5
    echo "on" > "$STATE_FILE"
fi
