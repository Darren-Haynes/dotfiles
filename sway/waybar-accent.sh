#!/bin/bash
# Write waybar/accent.css (imported by waybar/style.css) from the saved accent.
#   waybar-accent.sh [accent]    accent defaults to the saved one, then pink
# waybar exits if that import is missing, so this runs before every waybar
# start (sway/config) as well as on every accent change (toggle-theme.sh).
# The bar is always dark, so it uses the dark shade of the accent.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/bubblegum-accents.sh
. "$DOTFILES/bash-scripts/bubblegum-accents.sh"

accent="${1:-$(cat "$HOME/.local/state/bubblegum/accent" 2>/dev/null)}"
colour=$(accent_color dark "$accent") || colour=$(accent_color dark pink)
printf '@define-color bubblegum_accent %s;\n' "$colour" > "$DOTFILES/waybar/accent.css"
