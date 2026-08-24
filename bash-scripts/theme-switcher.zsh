#!/usr/bin/env zsh

WEZTERM_CONFIG="$HOME/Dotfiles/wezterm/wezterm.lua"
ZED_CONFIG="$HOME/Dotfiles/zed/settings.json"

typeset -A THEMES
THEMES=(
    "Ayu Mirage"      "Ayu Mirage|Ayu Mirage"
    "Bluloco Dark"    "BlulocoDark|Bluloco Dark"
    "Solarized Dark"  "Solarized Dark (Gogh)|Solarized Dark"
    "Oceanic Next"    "OceanicNext (base16)|Oceanic Next"
    "Pop Dark"        "Zenburn (base16)|Pop Dark"
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

SELECTION=$(print -l ${(k)THEMES} | fzf --prompt="Choose Theme > ")

if [ -z "$SELECTION" ]; then
    echo "No theme selected. Exiting."
    exit 0
fi

MAPPING_ARR=("${(@s:|:)THEMES[$SELECTION]}")
WEZTERM_THEME="${MAPPING_ARR[1]}"
ZED_THEME="${MAPPING_ARR[2]}"

echo "Applying '$SELECTION'..."

# Cross-platform sed
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

if [ $? -eq 0 ]; then
    echo "✓ Theme successfully updated!"
    echo "  WezTerm: $WEZTERM_THEME"
    echo "  Zed: $ZED_THEME"
    echo "  (WezTerm will auto-reload on file change)"
else
    echo "✗ Error updating configuration files."
    exit 1
fi
