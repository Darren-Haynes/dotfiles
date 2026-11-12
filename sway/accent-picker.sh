#!/bin/bash
# Pick the Bubblegum accent colour (pink / blue / green) from a rofi menu.
# The choice is applied live by toggle-theme.sh --accent (GTK, icons, dunst).

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/bubblegum-accents.sh
. "$DOTFILES/bash-scripts/bubblegum-accents.sh"

case "$(gsettings get org.gnome.desktop.interface gtk-theme)" in
    *Light*) variant=light ;;
    *)       variant=dark ;;
esac
current=$(cat "$HOME/.local/state/bubblegum/accent" 2>/dev/null)
[ -n "$current" ] || current=pink

entries=""
selected=0
i=0
for accent in $BUBBLEGUM_ACCENTS; do
    colour=$(accent_color dark "$accent")   # the menu itself is always dark
    mark="  "
    [ "$accent" = "$current" ] && { mark="✓ "; selected=$i; }
    entries+="<span foreground='${colour}'>●●●</span>  ${mark}${accent^}\n"
    i=$((i + 1))
done

choice=$(printf '%b' "$entries" | rofi -dmenu -i -markup-rows -p "Accent" \
    -theme bubblegum \
    -theme-str "* { accent-blue: $(accent_color dark "$current")ff; }
                window { width: 420px; }
                listview { lines: 3; }" \
    -selected-row "$selected" -format 'i')

[ -z "$choice" ] && exit 0

set -- $BUBBLEGUM_ACCENTS
shift "$choice"
exec "$DOTFILES/sway/toggle-theme.sh" --accent "$1"
