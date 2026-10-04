#!/bin/bash

# Define named workspace variables (exactly matching your config)
WS1="1: Term"
WS2="2: Browse"
WS9="9"

# Helper function to check if a specific application window exists in the Sway tree
is_app_running() {
    swaymsg -t get_tree | grep -q "\"app_id\": \"$1\""
}

# ----------------------------------------------------
# TOGGLE LOGIC: Check if Focus Mode is Active
# ----------------------------------------------------
if swaymsg -t get_outputs | grep -q "\"current_workspace\": \"$WS9\"" || swaymsg -t get_tree | grep -q '"name": "9"'; then

    # HOME DIRECTION: Send them back to their native spaces
    swaymsg "[app_id=\"Alacritty\"] move container to workspace $WS1"
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS2"

    # Take you straight back to your main Alacritty terminal workspace
    swaymsg "workspace $WS1"
    exit 0
fi

# ----------------------------------------------------
# FOCUS MODE ACTIVATION: Open / Relocate and Pair Apps (Brave Left, Alacritty Right)
# ----------------------------------------------------
# 1. Instantly switch to Workspace 9 to handle the landing canvas
swaymsg "workspace $WS9"

# 2. Handle BRAVE BROWSER FIRST (Locks it to the Left hand side)
if is_app_running "brave-browser"; then
    swaymsg "[app_id=\"brave-browser\"] move container to workspace $WS9"
else
    exec brave-browser &
    while ! is_app_running "brave-browser"; do sleep 0.1; done
fi

# Force Brave to split horizontally for its incoming partner (Alacritty)
swaymsg "[app_id=\"brave-browser\"] focus"
swaymsg "splith"

# 3. Handle ALACRITTY TERMINAL (Lands perfectly on the Right hand side)
if is_app_running "Alacritty"; then
    swaymsg "[app_id=\"Alacritty\"] move container to workspace $WS9"
else
    exec alacritty -e zellij attach -c "DOTFILES" options --default-cwd "$HOME/Dotfiles" &
    while ! is_app_running "Alacritty"; do sleep 0.1; done
fi

# Focus Alacritty so your terminal prompt cursor is immediately active on arrival
swaymsg "[app_id=\"Alacritty\"] focus"
