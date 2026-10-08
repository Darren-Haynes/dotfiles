#!/bin/bash

# ==============================================================================
# Dynamic Focus-Warp Pair Engine (Metadata Delimiter Boundary Fix)
# Zero-state live tree parser optimized for koalefant's Bubblegum workstation
# ==============================================================================

WS9="9: "

# Function to dynamically route windows home
evacuate_window() {
    local WIN="$1"
    case "$WIN" in
        "foot-main")     swaymsg "[app_id=\"$WIN\"] move container to workspace \"1: \"" ;;
        "brave-browser") swaymsg "[app_id=\"$WIN\"] move container to workspace \"2: \"" ;;
        "dev.zed.Zed")   swaymsg "[app_id=\"$WIN\"] move container to workspace \"3: \"" ;;
        *)               swaymsg "[app_id=\"$WIN\"] move container to workspace \"1: \"" ;;
    esac
}

# 1. Fetch all open, non-floating, non-scratchpad windows across the tree
APPS=$(swaymsg -t get_tree | jq -r '
  .. | select(.type? == "con" and .app_id? != null and .scratchpad_state? == "none") | .app_id
' | sort -u)

readarray -t APP_LIST <<< "$APPS"
NUM_APPS=${#APP_LIST[@]}

# 2. Build the Rofi input options list with precise inline metadata delimiters
# The newline (\n) must sit STRICTLY at the end of the entire metadata sequence block!
ROFI_OPTIONS="🧹 CLEAR CURRENT SPLIT WORKSPACE\0icon\x1fedit-clear\n"

for ((i=0; i<$NUM_APPS; i++)); do
    for ((j=i+1; j<$NUM_APPS; j++)); do

        # Translate your custom isolated identifiers into recognized desktop file keys
        case "${APP_LIST[i]}" in
            "foot-main")               ICON_A="utilities-terminal" ;;
            "dev.zed.Zed")             ICON_A="zed" ;;
            "eu.betterbird.Betterbird") ICON_A="betterbird" ;;
            *)                         ICON_A="${APP_LIST[i]}" ;;
        esac

        # FIX: The \n is shifted to the absolute end of the row string context!
        ROFI_OPTIONS+="${APP_LIST[i]}   <--->   ${APP_LIST[j]}\0icon\x1f${ICON_A}\n"
    done
done

# 3. Stream the layout pairs cleanly straight through your Rofi theme
SELECTION=$(echo -e "$ROFI_OPTIONS" | sed '/^$/d' | rofi -dmenu -show-icons -p "🧬 Pair Target" -theme bubblegum)

# Exit out smoothly if the user presses Escape or closes Rofi
[ -z "$SELECTION" ] && exit 0

# ----------------------------------------------------
# ACTION A: Clear Workspace 9 Option Triggered
# ----------------------------------------------------
if [ "$SELECTION" == "🧹 CLEAR CURRENT SPLIT WORKSPACE" ]; then
    CURRENT_WS9_WINS=$(swaymsg -t get_tree | jq -r --arg ws "$WS9" '
      .. | select(.name? == $ws) | .. | select(.type? == "con" and .app_id? != null) | .app_id
    ')

    for WIN in $CURRENT_WS9_WINS; do
        evacuate_window "$WIN"
    done

    notify-send "Dynamic Warp" "Workspace 9 cleared cleanly!"
    exit 0
fi

# ----------------------------------------------------
# ACTION B: Pairing Option Triggered
# ----------------------------------------------------
APP_A=$(echo "$SELECTION" | awk -F '   <--->   ' '{print $1}')
APP_B=$(echo "$SELECTION" | awk -F '   <--->   ' '{print $2}')

CURRENT_WS9_WINS=$(swaymsg -t get_tree | jq -r --arg ws "$WS9" '
  .. | select(.name? == $ws) | .. | select(.type? == "con" and .app_id? != null) | .app_id
')

for WIN in $CURRENT_WS9_WINS; do
    if [ "$WIN" != "$APP_A" ] && [ "$WIN" != "$APP_B" ]; then
        evacuate_window "$WIN"
    fi
done

# Focus Mode Activation: Move and tile your chosen application pairs side-by-side
swaymsg "workspace $WS9"
swaymsg "[app_id=\"$APP_A\"] move container to workspace \"$WS9\""
swaymsg "[app_id=\"$APP_A\"] focus"
swaymsg "splith"
swaymsg "[app_id=\"$APP_B\"] move container to workspace \"$WS9\""
swaymsg "[app_id=\"$APP_B\"] focus"
