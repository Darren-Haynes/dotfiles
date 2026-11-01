#!/bin/bash
# $mod+Return handler. Keeps the "foot-main" terminal (the one the split
# scripts rely on) alive on workspace 1.
#
# On any workspace other than 1: open a normal terminal.
# On workspace 1:
#   - foot-main already on workspace 1  -> open a normal extra terminal
#   - foot-main on another workspace    -> move it to workspace 1 and focus it
#   - no foot-main anywhere             -> create it (app-id foot-main) here
# Set DRY_RUN=1 to print the decision without doing anything.

MAIN_ID="foot-main"

act() {
    if [ -n "$DRY_RUN" ]; then echo "would: $*"; else "$@"; fi
}

focused_num=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .num')

if [ "$focused_num" != "1" ]; then
    act foot
    exit 0
fi

# Number of the workspace holding foot-main (empty if it doesn't exist).
main_ws=$(swaymsg -t get_tree | jq -r --arg id "$MAIN_ID" '
    [ .. | objects | select(.type? == "workspace") | . as $w
      | select([$w | .. | objects | select(.app_id? == $id)] | length > 0)
      | $w.num ] | first // empty')

if [ -z "$main_ws" ]; then
    act setsid -f foot --app-id="$MAIN_ID"
elif [ "$main_ws" = "1" ]; then
    act foot
else
    act swaymsg "[app_id=\"$MAIN_ID\"] move container to workspace number 1"
    act swaymsg "[app_id=\"$MAIN_ID\"] focus"
fi
