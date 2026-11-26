#!/bin/bash
# Point btop at the active family's theme and make a running btop reload it.
#   apply-btop-theme.sh [family]    (default: the saved family)
# btop/btop.conf loads btop/themes/active.theme (gitignored), which is a symlink
# to btop/themes/<family>.theme. btop reloads its config on SIGUSR2.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

family="${1:-$(theme_current_family)}"
[ -f "$DOTFILES/btop/themes/$family.theme" ] || family=bubblegum
ln -sfn "$family.theme" "$DOTFILES/btop/themes/active.theme"
pkill -SIGUSR2 -x btop 2>/dev/null
exit 0
