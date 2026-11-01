#!/bin/bash

# ==============================================================================
# Focus Workspace Tiling Script (Foot + Zed)
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
    swaymsg "[app_id=\"dev.zed.Zed\"] move container to workspace $WS3"

    # Take you straight back to your main foot terminal workspace
    swaymsg "workspace $WS1"
    swaymsg "[app_id=\"foot-main\"] focus"
    exit 0
fi

# ----------------------------------------------------
# FOCUS MODE ACTIVATION: Open / Relocate and Pair Apps (foot Left, Zed Right)
# ----------------------------------------------------
# 1. Instantly switch to Workspace 9 to handle the landing canvas
swaymsg "workspace $WS9"

# 2. Handle foot TERMINAL FIRST (Locks it to the Left hand side)
# FIX: Evaluate your isolated app identifier name string exactly!
# Create foot-main (with the DOTFILES zellij session) if it does not exist,
# then pull it onto workspace 9. A freshly created one lands on workspace 1
# via the assign rule in sway/config, so it always needs moving.
"$ENSURE_MAIN" --zellij
swaymsg "[app_id=\"foot-main\"] move container to workspace $WS9"

# Force foot to split horizontally for its incoming partner (Zed)
swaymsg "[app_id=\"foot-main\"] focus"
swaymsg "splith"

# 3. Handle ZED EDITOR (Lands perfectly on the Right hand side)
if is_app_running "dev.zed.Zed"; then
    swaymsg "[app_id=\"dev.zed.Zed\"] move container to workspace $WS9"
else
    zsh -lc "$HOME/.local/bin/zed --foreground" &
    while ! is_app_running "dev.zed.Zed"; do sleep 0.1; done
fi

# Focus Zed so your code editing cursor is immediately active on arrival
swaymsg "[app_id=\"dev.zed.Zed\"] focus"
