#!/bin/bash
# Build Bubblegum-coloured copies of the Colloid-Pink icon themes, one per accent.
# Colloid draws folder icons using the CSS var ".ColorScheme-Highlight { color:#F06292 }"
# (only in places/), so recolouring = swapping that one hex value.
#
# Usage: make-bubblegum-icons.sh [accent ...]   (default: all accents in bubblegum-accents.sh)
# Safe to re-run; rebuilds from the Colloid-Pink sources.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=bubblegum-accents.sh
. "$SCRIPT_DIR/bubblegum-accents.sh"

ICON_DIR="$HOME/.local/share/icons"
ORIG_PINK="#F06292"

build() {
    local src="$1" dst="$2" color="$3"

    if [ ! -d "$ICON_DIR/$src" ]; then
        echo "Missing source icon theme: $ICON_DIR/$src" >&2
        exit 1
    fi

    rm -rf "${ICON_DIR:?}/$dst"
    cp -a "$ICON_DIR/$src" "$ICON_DIR/$dst"

    # -type f so symlinks (many icons are links) are left alone
    find "$ICON_DIR/$dst" -type f -name '*.svg' -exec sed -i "s/${ORIG_PINK}/${color}/Ig" {} +

    sed -i "s/^Name=.*/Name=${dst}/" "$ICON_DIR/$dst/index.theme"
    rm -f "$ICON_DIR/$dst/icon-theme.cache"
    gtk-update-icon-cache -f -q "$ICON_DIR/$dst"
    echo "Built $dst ($color)"
}

accents="${*:-$BUBBLEGUM_ACCENTS}"
for accent in $accents; do
    build Colloid-Pink-Dark  "$(icon_theme_name dark  "$accent")" "$(accent_color dark  "$accent")"
    build Colloid-Pink-Light "$(icon_theme_name light "$accent")" "$(accent_color light "$accent")"
done
