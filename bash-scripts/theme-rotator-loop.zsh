#!/usr/bin/env zsh

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <minutes>"
    echo "Example: $0 5  (Runs every 5 minutes)"
    exit 1
fi

INTERVAL_MINUTES=$1
INTERVAL_SECONDS=$((INTERVAL_MINUTES * 60))

# Paths to your configuration files
WEZTERM_CONFIG="$HOME/Dotfiles/wezterm/wezterm.lua"
ZED_CONFIG="$HOME/Dotfiles/zed/settings.json"

# Define theme mappings
typeset -A THEMES
THEMES=(
    "Ayu Mirage"      "Ayu Mirage|Ayu Mirage"
    "Bluloco Dark"    "BlulocoDark|Bluloco Dark"
    "Solarized Dark"  "Solarized Dark (Gogh)|Solarized Dark"
    "Oceanic Next"    "Oceanic-Next|Oceanic Next"
    "Pop Dark"        "Pop (base16)|Pop Dark"
    "Zenburn"         "Zenburn (base16)|Zenburn"
    "One Dark"        "One Dark (Gogh)|One Dark"
    "Tokyo Storm"     "Tokyo Night Storm (Gogh)|Tokyo Night Storm"
    "Nord Fox"        "nordfox|Nordfox"
    "Catppuccin"      "Catppuccin Frappé (Gogh)|Catppuccin Frappé"
    "Mariana"         "Mariana|Mariana Sublime"
    "Forest Night"    "Everforest Dark (Gogh)|Forest Night"
    "shhhed"          "shhhed|shhhed"
    "Dram"            "dram|Dram"
    "Pruple"          "MaterialDark|Pruple"
    "Rose Pine"       "Rosé Pine Moon (base16)|Rosé Pine Moon"
    "Green"           "Apathy (base16)|Base16 Apathy"
)

# Function to apply a random theme
apply_random_theme() {
    # Use (@k) flag correctly quoted to handle spaces/special chars in keys
    local -a THEME_KEYS
    THEME_KEYS=("${(@k)THEMES}")

    local RANDOM_INDEX=$(( $RANDOM % $#THEME_KEYS + 1 ))
    local SELECTION="${THEME_KEYS[$RANDOM_INDEX]}"

    local MAPPING_ARR=("${(@s:|:)THEMES[$SELECTION]}")
    local WEZTERM_THEME="${MAPPING_ARR[1]}"
    local ZED_THEME="${MAPPING_ARR[2]}"

    # Cross-platform sed setup
    local -a SED_INPLACE
    if [[ "$OSTYPE" == "darwin"* ]]; then
        SED_INPLACE=(-i "")
    else
        SED_INPLACE=(-i)
    fi

    # Update WezTerm Config
    sed "${SED_INPLACE[@]}" -E "s/(config\.color_scheme = ')[^']+'(.*-- THEME_SWITCHER_SCHEME)/\1$WEZTERM_THEME'\2/" "$WEZTERM_CONFIG"
    sed "${SED_INPLACE[@]}" -E "s/(local active_theme_name = ')[^']+'(.*-- THEME_SWITCHER_ACTIVE)/\1$WEZTERM_THEME'\2/" "$WEZTERM_CONFIG"

    # Update Zed Config
    sed "${SED_INPLACE[@]}" -E "s/(\"dark\": \")[^\"]+(\".*\/\/ THEME_SWITCHER_DARK)/\1$ZED_THEME\2/" "$ZED_CONFIG"

    # Log the change
    local TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$TIMESTAMP] Applied: $SELECTION" >> "$HOME/.theme_rotator.log"
    echo "✓ Applied: $SELECTION (Next in $INTERVAL_MINUTES min)"
}

# Initial run
echo "Starting theme rotator (Interval: $INTERVAL_MINUTES minutes)..."
echo "Press Ctrl+C to stop."
apply_random_theme

# Loop indefinitely
while true; do
    sleep $INTERVAL_SECONDS
    apply_random_theme
done
