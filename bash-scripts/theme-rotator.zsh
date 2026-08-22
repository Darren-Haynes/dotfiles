#!/usr/bin/env zsh

# Paths to your configuration files
WEZTERM_CONFIG="$HOME/Dotfiles/wezterm/wezterm.lua"
ZED_CONFIG="$HOME/Dotfiles/zed/settings.json"

# Define theme mappings: ["Display Name"]="WeztermTheme|ZedTheme"
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

# 1. Pick a random key from the THEMES associative array
# $RANDOM % $#THEMES + 1 generates a random index between 1 and the total count
THEME_KEYS=("${(@k)THEMES}")
RANDOM_INDEX=$(( $RANDOM % $#THEME_KEYS + 1 ))
SELECTION="${THEME_KEYS[$RANDOM_INDEX]}"

# 2. Extract specific theme names
MAPPING_ARR=("${(@s:|:)THEMES[$SELECTION]}")
WEZTERM_THEME="${MAPPING_ARR[1]}"
ZED_THEME="${MAPPING_ARR[2]}"

# 3. Cross-platform sed setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INPLACE=(-i "")
else
    SED_INPLACE=(-i)
fi

# 4. Update WezTerm Config
sed "${SED_INPLACE[@]}" -E "s/(config\.color_scheme = ')[^']+'(.*-- THEME_SWITCHER_SCHEME)/\1$WEZTERM_THEME'\2/" "$WEZTERM_CONFIG"
sed "${SED_INPLACE[@]}" -E "s/(local active_theme_name = ')[^']+'(.*-- THEME_SWITCHER_ACTIVE)/\1$WEZTERM_THEME'\2/" "$WEZTERM_CONFIG"

# 5. Update Zed Config
sed "${SED_INPLACE[@]}" -E "s/(\"dark\": \")[^\"]+(\".*\/\/ THEME_SWITCHER_DARK)/\1$ZED_THEME\2/" "$ZED_CONFIG"

# 6. Log the change (useful for cron debugging)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] Applied theme: $SELECTION (WezTerm: $WEZTERM_THEME, Zed: $ZED_THEME)" >> "$HOME/.theme_rotator.log"
