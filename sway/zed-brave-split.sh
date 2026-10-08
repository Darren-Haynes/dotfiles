#!/bin/bash

# ==============================================================================
# Focus Workspace Tiling Script (Zed + Brave)
# Fully optimized for koalefant's modular workspace icon matrix
# ==============================================================================

# Define named workspace variables (exactly matching your main sway config)
WS1="1: "
WS2="2: "
WS3="3: "
WS9="9: " # FIX: Synced to use your Font Awesome split window icon!

# Helper function to check if a specific application window exists in the Sway tree
is_app_running() {
    swaymsg -t get_tree | grep -q "\"app_id\": \"$1\""
}

# ----------------------------------------------------
# TOGGLE LOGIC: Check if Focus Mode is Active
# ----------------------------------------------------
# We check if Workspace 9 is active or exists in the layout architecture.
if swaymsg -t get_outputs | grep -q "\"current_workspace\": \"$WS9\"" || swaymsg -t get_tree | grep -q "\"name\": \"$WS9\""; then

    # HOME DIRECTION: Vacuum them back out to their native home row coordinates
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS2"
    swaymsg "[app_id=\"dev.zed.Zed\"] move container to workspace $WS3"

    # Take you straight back to your main high-efficiency development cockpit
    # FIX: Pointed directly to foot-main's home row workspace
    swaymsg "workspace $WS1"
    swaymsg "[app_id=\"foot-main\"] focus"
    exit 0
fi

# ----------------------------------------------------
# FOCUS MODE ACTIVATION: Open / Relocate and Pair Apps
# ----------------------------------------------------
# 1. Instantly switch to Workspace 9 to handle the landing canvas layout
swaymsg "workspace $WS9"

# 2. Handle BRAVE BROWSER
if is_app_running "brave-browser"; then
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS9"
else
    brave-browser &
    while ! is_app_running "brave-browser"; do sleep 0.1; done
fi

# Force Brave to split horizontally for its incoming coding workspace partner
swaymsg "[app_id=\"brave-browser\"] focus"
swaymsg "splith"

# 3. Handle ZED EDITOR
if is_app_running "dev.zed.Zed"; then
    swaymsg "[app_id=\"dev.zed.Zed\"] move container to workspace $WS9"
else
    zsh -lc "$HOME/.local/bin/zed --foreground" &
    while ! is_app_running "dev.zed.Zed"; do sleep 0.1; done
fi

# Focus Zed so your typing cursor is live and ready on arrival over your VNC link
swaymsg "[app_id=\"dev.zed.Zed\"] focus"
