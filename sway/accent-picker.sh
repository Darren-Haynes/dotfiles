#!/bin/bash
# Pick the accent colour for the current theme family from a rofi menu
# (Bubblegum: pink / blue / green / mono, shhhed: green / blue / rose / mono).
# The choice is applied live by toggle-theme.sh --accent.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

family=$(theme_current_family)
current=$(theme_current_accent "$family")
accents=$(theme_accents "$family")

entries=""
selected=0
i=0
for accent in $accents; do
    colour=$(accent_color "$family" dark "$accent")   # the menu itself is always dark
    mark="  "
    [ "$accent" = "$current" ] && { mark="✓ "; selected=$i; }
    entries+="<span foreground='${colour}'>●●●</span>  ${mark}${accent^}\n"
    i=$((i + 1))
done

choice=$(printf '%b' "$entries" | rofi -dmenu -i -markup-rows -p "Accent" \
    -theme bubblegum \
    -theme-str "* { accent-blue: $(accent_color "$family" dark "$current")ff; }
                window { width: 420px; }
                listview { lines: 4; }" \
    -selected-row "$selected" -format 'i')

[ -z "$choice" ] && exit 0

# shellcheck disable=SC2086
set -- $accents
shift "$choice"
exec "$DOTFILES/sway/toggle-theme.sh" --accent "$1"
