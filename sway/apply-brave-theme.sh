#!/bin/bash
# Point Brave's Bubblegum theme at the dark or light variant.
#   apply-brave-theme.sh [dark|light]   (default: the current GNOME color-scheme)
#
# Brave loads the theme as an unpacked extension from
#   ~/.local/share/bubblegum/brave-theme
# whose manifest.json is a copy of the dark (manifest.json) or light
# (manifest-light.json) manifest from Dotfiles/brave/brave-theme-bubblegum.
# Chromium only reads an unpacked theme when the browser starts (or when you
# press Reload on brave://extensions), so a running Brave switches then; this
# script never touches Brave's profile or the running browser.

variant="$1"
if [ -z "$variant" ]; then
    case "$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)" in
        *prefer-light*) variant=light ;;
        *)              variant=dark ;;
    esac
fi
SRC="$HOME/Dotfiles/brave/brave-theme-bubblegum"
DEST="$HOME/.local/share/bubblegum/brave-theme"

case "$variant" in
    dark)  manifest="$SRC/manifest.json" ;;
    light) manifest="$SRC/manifest-light.json" ;;
    *) echo "usage: $0 dark|light" >&2; exit 1 ;;
esac

mkdir -p "$DEST"
cp -f "$manifest" "$DEST/manifest.json"
