#!/usr/bin/env zsh

WEZTERM_CONFIG="$HOME/Dotfiles/wezterm/wezterm.lua"
ZED_CONFIG="$HOME/Dotfiles/zed/settings.json"
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"

typeset -A THEMES
THEMES=(
    "Apple"           "Apple System Colors|macOS Classic Dark|default.jpg"
    "Ayu Mirage"      "Ayu Mirage|Ayu Mirage|default.jpg"
    "Bubblegum"       "Zenburn (base16)|Bubblegum|default.jpg"
    "Dram"            "dram|Dram|dram.jpg"
    "Everforest"      "Everforest Dark (Gogh)|Base16 Everforest Dark Hard|everforest.jpg"
    "Gnome Dark"      "adwaita|Dark Gnome|default.jpg"
    "Oceanic Next"    "OceanicNext (base16)|Base16 OceanicNext|default.jpg"
    "One Dark"        "One Dark (Gogh)|One Dark|default.jpg"
    "Rose Pine"       "Rosé Pine Moon (base16)|Base16 Rosé Pine Moon|default.jpg"
    "shhhed"          "shhhed|shhhed|shhhed.jpg"
    "Tokyo Storm"     "Tokyo Night Storm (Gogh)|Base16 Tokyo Night Storm|default.jpg"
    "Zenburn"         "Zenburn (base16)|Base16 Zenburn|default.jpg"
)

select_theme() {
    print -l ${(k)THEMES} | fzf --prompt="Choose Theme > "
}

parse_theme_mapping() {
    local selection="$1"
    local -a mapping

    mapping=("${(@s:|:)THEMES[$selection]}")
    print -r -- "${mapping[1]}|${mapping[2]}|${mapping[3]}"
}

is_fedora_gnome() {
    [[ -r /etc/os-release ]] || return 1

    local os_id="" os_version_id="" current_desktop="${XDG_CURRENT_DESKTOP:-}"
    local key value

    while IFS='=' read -r key value; do
        case "$key" in
            ID)
                os_id="${value%\"}"
                os_id="${os_id#\"}"
                ;;
            VERSION_ID)
                os_version_id="${value%\"}"
                os_version_id="${os_version_id#\"}"
                ;;
        esac
    done < /etc/os-release

    [[ "$os_id" == "fedora" && "$os_version_id" == "44" && "${current_desktop:l}" == *gnome* ]]
}

wallpaper_path_for() {
    print -r -- "$WALLPAPER_DIR/$1"
}

update_wezterm_config() {
    local wezterm_theme="$1"
    local -a sed_inplace
    local rc=0

    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed_inplace=(-i "")
    else
        sed_inplace=(-i)
    fi

    sed "${sed_inplace[@]}" -E "s/(config\.color_scheme = ')[^']+'(.*-- THEME_SWITCHER_SCHEME)/\1$wezterm_theme'\2/" "$WEZTERM_CONFIG" || rc=$?
    sed "${sed_inplace[@]}" -E "s/(local active_theme_name = ')[^']+'(.*-- THEME_SWITCHER_ACTIVE)/\1$wezterm_theme'\2/" "$WEZTERM_CONFIG" || rc=$?

    return $rc
}

update_zed_config() {
    local zed_theme="$1"
    local -a sed_inplace
    local rc=0

    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed_inplace=(-i "")
    else
        sed_inplace=(-i)
    fi

    sed "${sed_inplace[@]}" -E "s/(\"dark\": \")[^\"]+(\".*\/\/ THEME_SWITCHER_DARK)/\1$zed_theme\2/" "$ZED_CONFIG" || rc=$?

    return $rc
}

update_gnome_wallpaper() {
    local wallpaper_file="$1"
    local wallpaper_uri rc=0

    wallpaper_uri="file://$(wallpaper_path_for "$wallpaper_file")"
    gsettings set org.gnome.desktop.background picture-uri "$wallpaper_uri" || rc=$?
    gsettings set org.gnome.desktop.background picture-uri-dark "$wallpaper_uri" || rc=$?

    return $rc
}

SELECTION=$(select_theme)

if [ -z "$SELECTION" ]; then
    echo "No theme selected. Exiting."
    exit 0
fi

MAPPING="$(parse_theme_mapping "$SELECTION")"
WEZTERM_THEME="${MAPPING%%|*}"
REST="${MAPPING#*|}"
ZED_THEME="${REST%%|*}"
WALLPAPER_FILE="${REST#*|}"

if [[ "$WALLPAPER_FILE" == "$REST" ]]; then
    WALLPAPER_FILE="default.jpg"
fi

echo "Applying '$SELECTION'..."

CONFIG_STATUS=0
update_wezterm_config "$WEZTERM_THEME" || CONFIG_STATUS=$?
update_zed_config "$ZED_THEME" || CONFIG_STATUS=$?

WALLPAPER_STATUS=0
if is_fedora_gnome; then
    update_gnome_wallpaper "$WALLPAPER_FILE" || WALLPAPER_STATUS=$?
fi

if [[ $CONFIG_STATUS -eq 0 && $WALLPAPER_STATUS -eq 0 ]]; then
    echo "✓ Theme successfully updated!"
    echo "  WezTerm: $WEZTERM_THEME"
    echo "  Zed: $ZED_THEME"
    echo "  Wallpaper: $WALLPAPER_FILE"
    echo "  (WezTerm will auto-reload on file change)"
else
    echo "✗ Error updating configuration files."
    exit 1
fi
