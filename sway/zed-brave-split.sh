#!/bin/bash

# Define named workspace variables (exactly matching your config)
WS1="1: Term"
WS2="2: Browse"
WS3="3: Zed"
WS9="9"

# Helper function to check if a specific application window exists in the Sway tree
is_app_running() {
    swaymsg -t get_tree | grep -q "\"app_id\": \"$1\""
}

# ----------------------------------------------------
# TOGGLE LOGIC: Check if Focus Mode is Active
# ----------------------------------------------------
# We check if Workspace 9 is populated. If it is, we are going home.
if swaymsg -t get_outputs | grep -q "\"current_workspace\": \"$WS9\"" || swaymsg -t get_tree | grep -q '"name": "9"'; then

    # HOME DIRECTION: Send them back to their native spaces
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS2"
    swaymsg "[app_id=\"dev.zed.Zed\"] move container to workspace $WS3"

    # Take you straight back to your main Alacritty cockpit
    swaymsg "workspace $WS1"
    exit 0
fi

# ----------------------------------------------------
# FOCUS MODE ACTIVATION: Open / Relocate and Pair Apps
# ----------------------------------------------------
# 1. Instantly switch to Workspace 9 to handle the landing canvas
swaymsg "workspace $WS9"

# 2. Handle BRAVE BROWSER
if is_app_running "brave-browser"; then
    # If running, vacuum it over from Workspace 2
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS9"
else
    # If completely closed, launch it fresh right here
    exec brave-browser &
    # Wait for the Wayland display manager to map the window frame
    while ! is_app_running "brave-browser"; do sleep 0.1; done
fi

# Force Brave to split horizontally for its incoming partner
swaymsg "[app_id=\"brave-browser\"] focus"
swaymsg "splith"

# 3. Handle ZED EDITOR
if is_app_running "dev.zed.Zed"; then
    # If running, vacuum it over from Workspace 3
    swaymsg "[app_id=\"dev.zed.Zed\"] move container to workspace $WS9"
else
    # If closed, boot it with your path wrapper to ensure NVM loads cleanly
    exec zsh -lc "$HOME/.local/bin/zed --foreground" &
    # Wait for the frame to register
    while ! is_app_running "dev.zed.Zed"; do sleep 0.1; done
fi

# Focus Zed so your typing cursor is live and ready on arrival
swaymsg "[app_id=\"dev.zed.Zed\"] focus"
