#!/usr/bin/env zsh

# Paths to your configuration files
WEZTERM_CONFIG="$HOME/Dotfiles/wezterm/wezterm.lua"
ZED_CONFIG="$HOME/Dotfiles/zed/settings.json"

# Define theme mappings in Zsh: ["Display Name"]="WeztermTheme|ZedTheme"
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
)

# 1. Prompt the user to select a theme using fzf
SELECTION=$(print -l ${(k)THEMES} | fzf --prompt="Choose Theme > ")

if [ -z "$SELECTION" ]; then
    echo "No theme selected. Exiting."
    exit 0
fi

# 2. Extract specific theme names properly using Zsh array splitting
# (s:|:) splits the string by '|', [@]-style extraction assigns it to a temporary array
MAPPING_ARR=("${(@s:|:)THEMES[$SELECTION]}")
WEZTERM_THEME="${MAPPING_ARR[1]}"
ZED_THEME="${MAPPING_ARR[2]}"

echo "Applying '$SELECTION'..."

# 3. Update WezTerm Config safely matching the exact structure
sed -i "" -E "s/(config\.color_scheme = ')[^']+'(.*-- THEME_SWITCHER_SCHEME)/\1$WEZTERM_THEME'\2/" "$WEZTERM_CONFIG"
sed -i "" -E "s/(local active_theme_name = ')[^']+'(.*-- THEME_SWITCHER_ACTIVE)/\1$WEZTERM_THEME'\2/" "$WEZTERM_CONFIG"

# 4. Update Zed Config using macOS-compatible sed
sed -i "" -E "s/(\"dark\": \")[^\"]+(\".*\/\/ THEME_SWITCHER_DARK)/\1$ZED_THEME\2/" "$ZED_CONFIG"

# 5. Output completion status
# (WezTerm watches the file natively, so no CLI reload command is needed!)
if [ $? -eq 0 ]; then
    echo "Theme successfully updated! (WezTerm will auto-reload momentarily)"
else
    echo "Something went wrong while modifying the files."
fi
