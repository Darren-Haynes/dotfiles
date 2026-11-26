#!/bin/bash
# Pick the theme family (Bubblegum / shhhed) from a rofi menu. The choice is
# applied live by toggle-theme.sh --family; dark/light and each family's own
# accent are kept.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

current=$(theme_current_family)

entries=""
selected=0
i=0
for family in $THEME_FAMILIES; do
    colour=$(accent_color "$family" dark "$(theme_current_accent "$family")")
    mark="  "
    [ "$family" = "$current" ] && { mark="✓ "; selected=$i; }
    entries+="<span foreground='${colour}'>●●●</span>  ${mark}$(theme_family_label "$family")\n"
    i=$((i + 1))
done

choice=$(printf '%b' "$entries" | rofi -dmenu -i -markup-rows -p "Theme" \
    -theme bubblegum \
    -theme-str "window { width: 420px; }
                listview { lines: 2; }" \
    -selected-row "$selected" -format 'i')

[ -z "$choice" ] && exit 0

# shellcheck disable=SC2086
set -- $THEME_FAMILIES
shift "$choice"
exec "$DOTFILES/sway/toggle-theme.sh" --family "$1"
