#!/bin/bash
# Build Bubblegum-colored copies of the Colloid-Pink icon themes.
# Colloid draws folder icons using the CSS var ".ColorScheme-Highlight { color:#F06292 }"
# (only in places/), so recoloring = swapping that one hex value.
#
# Usage: make-bubblegum-icons.sh   (safe to re-run; rebuilds from the Colloid sources)

set -euo pipefail

ICON_DIR="$HOME/.local/share/icons"
ORIG_PINK="#F06292"
DARK_PINK="#D7AFD7"   # matches Bubblegum (dark)
LIGHT_PINK="#B060A0"  # matches Bubblegum Light

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

build Colloid-Pink-Dark  Colloid-Bubblegum-Dark  "$DARK_PINK"
build Colloid-Pink-Light Colloid-Bubblegum-Light "$LIGHT_PINK"
