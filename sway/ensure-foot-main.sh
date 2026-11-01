#!/bin/bash
# Make sure a "foot-main" terminal exists; create it if not (sway/config's
# assign rule puts a new one on workspace 1). Waits until the window appears.
#   ensure-foot-main.sh            plain terminal
#   ensure-foot-main.sh --zellij   start inside the DOTFILES zellij session

exists() {
    swaymsg -t get_tree | jq -e '[.. | objects | select(.app_id? == "foot-main")] | length > 0' >/dev/null
}

exists && exit 0

if [ "$1" = "--zellij" ]; then
    setsid -f foot --app-id=foot-main -e zellij attach -c "DOTFILES" options --default-cwd "$HOME/Dotfiles"
else
    setsid -f foot --app-id=foot-main
fi

for _ in $(seq 1 50); do
    exists && exit 0
    sleep 0.1
done
exit 1
