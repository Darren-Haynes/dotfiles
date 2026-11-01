#!/bin/bash

# ==============================================================================
# Focus Workspace Tiling Script (Brave Left, Foot Right)
# Fully optimized for koalefant's modular workspace icon matrix
# ==============================================================================

# Define named workspace variables (exactly matching your config)
WS1="1: "
WS2="2: "
WS3="3: "
WS9="9: " # FIX: Synced to use your Font Awesome split window icon!

ENSURE_MAIN="$(dirname "$(readlink -f "$0")")/ensure-foot-main.sh"

# Helper function to check if a specific application window exists in the Sway tree
is_app_running() {
    swaymsg -t get_tree | grep -q "\"app_id\": \"$1\""
}

# ----------------------------------------------------
# TOGGLE LOGIC: Check if Focus Mode is Active
# ----------------------------------------------------
if swaymsg -t get_outputs | grep -q "\"current_workspace\": \"$WS9\"" || swaymsg -t get_tree | grep -q "\"name\": \"$WS9\""; then

    # HOME DIRECTION: Send them back to their native spaces
    "$ENSURE_MAIN"   # recreate foot-main if it was closed meanwhile
    swaymsg "[app_id=\"foot-main\"] move container to workspace $WS1"
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS2"

    # Take you straight back to your main foot terminal workspace
    swaymsg "workspace $WS1"
    swaymsg "[app_id=\"foot-main\"] focus"
    exit 0
fi

# ----------------------------------------------------
# FOCUS MODE ACTIVATION: Open / Relocate and Pair Apps (Brave Left, foot Right)
# ----------------------------------------------------
# 1. Instantly switch to Workspace 9 to handle the landing canvas
swaymsg "workspace $WS9"

# 2. Handle BRAVE BROWSER FIRST (Locks it to the Left hand side)
if is_app_running "brave-browser"; then
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS9"
else
    brave-browser &
    while ! is_app_running "brave-browser"; do sleep 0.1; done
fi

# Force Brave to split horizontally for its incoming partner (foot)
swaymsg "[app_id=\"brave-browser\"] focus"
swaymsg "splith"

# 3. Handle foot TERMINAL (Lands perfectly on the Right hand side)
# FIX: Evaluate your isolated app identifier name string exactly!
# Create foot-main (with the DOTFILES zellij session) if it does not exist,
# then pull it onto workspace 9. A freshly created one lands on workspace 1
# via the assign rule in sway/config, so it always needs moving.
"$ENSURE_MAIN" --zellij
swaymsg "[app_id=\"foot-main\"] move container to workspace $WS9"

# Focus foot so your terminal prompt cursor is immediately active on arrival
swaymsg "[app_id=\"foot-main\"] focus"
