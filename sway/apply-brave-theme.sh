#!/bin/bash
# Point Brave's theme at the right family + dark/light variant.
#   apply-brave-theme.sh [family [dark|light]]
#   (defaults: the saved family, and the current GNOME color-scheme)
#
# Brave loads the theme as an unpacked extension from
#   ~/.local/share/bubblegum/brave-theme
# whose manifest.json is a copy of the dark (manifest.json) or light
# (manifest-light.json) manifest from Dotfiles/brave/brave-theme-<family>.
# Chromium only reads an unpacked theme when the browser starts (or when you
# press Reload on brave://extensions), so a running Brave switches then; this
# script never touches Brave's profile or the running browser.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

family="${1:-$(theme_current_family)}"
variant="$2"
if [ -z "$variant" ]; then
    case "$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)" in
        *prefer-light*) variant=light ;;
        *)              variant=dark ;;
    esac
fi

SRC="$DOTFILES/brave/brave-theme-$family"
DEST="$HOME/.local/share/bubblegum/brave-theme"

[ -d "$SRC" ] || { echo "no Brave theme for family '$family'" >&2; exit 1; }
case "$variant" in
    dark)  manifest="$SRC/manifest.json" ;;
    light) manifest="$SRC/manifest-light.json" ;;
    *) echo "usage: $0 [family [dark|light]]" >&2; exit 1 ;;
esac

mkdir -p "$DEST"
cp -f "$manifest" "$DEST/manifest.json"
