#!/bin/bash
# Write waybar/accent.css (imported by waybar/style.css) from the saved family
# and accent.
#   waybar-accent.sh [accent]    accent defaults to the saved one for the family
# waybar exits if that import is missing, so this runs before every waybar
# start (sway/config) as well as on every theme change (toggle-theme.sh).
# The bar is always dark, so it uses the dark variant of the family.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

family=$(theme_current_family)
accent="${1:-$(theme_current_accent "$family")}"
colour=$(accent_color "$family" dark "$accent") || colour=$(accent_color "$family" dark "$(theme_default_accent "$family")")

tmp=$(mktemp "$DOTFILES/waybar/.accent.XXXXXX")
cat > "$tmp" <<EOF
@define-color bubblegum_accent $colour;
@define-color bar_bg $(theme_color "$family" dark bg);
@define-color bar_module $(theme_color "$family" dark raised);
@define-color bar_muted $(theme_color "$family" dark muted);
@define-color bar_fg $(theme_color "$family" dark fg);
@define-color bar_alert $(theme_color "$family" dark error);
EOF
mv -f "$tmp" "$DOTFILES/waybar/accent.css"
