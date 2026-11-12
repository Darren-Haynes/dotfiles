#!/bin/bash
# Generate the non-pink Bubblegum accent variants used by sway/accent-picker.sh:
#   - GTK3/GTK4 themes  -> ~/.local/share/themes/"Bubblegum Blue", "Bubblegum Light Green", ...
#   - folder icon themes -> ~/.local/share/icons/Colloid-Bubblegum-Blue-Dark, ... (make-bubblegum-icons.sh)
# They are copies of themes/Bubblegum and themes/"Bubblegum Light" with the
# pink accent swapped, so edit those source themes and re-run this script.
#
# Usage: make-bubblegum-accents.sh [accent ...]   (default: every accent except pink)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=bubblegum-accents.sh
. "$SCRIPT_DIR/bubblegum-accents.sh"

SRC_DIR="$(cd "$SCRIPT_DIR/../themes" && pwd)"
DST_DIR="$HOME/.local/share/themes"

accents="${*:-${BUBBLEGUM_ACCENTS/pink/}}"
mkdir -p "$DST_DIR"

for accent in $accents; do
    [ "$accent" = pink ] && continue   # pink is the source theme itself
    for variant in dark light; do
        src_name="$(gtk_theme_name "$variant" pink)"
        dst_name="$(gtk_theme_name "$variant" "$accent")"
        from="$(accent_color "$variant" pink)"
        to="$(accent_color "$variant" "$accent")"

        rm -rf "${DST_DIR:?}/$dst_name"
        cp -a "$SRC_DIR/$src_name" "$DST_DIR/$dst_name"
        find "$DST_DIR/$dst_name" -name '*.css' -exec sed -i "s/${from}/${to}/Ig" {} +
        sed -i "s/^Name=.*/Name=${dst_name}/; s/^Comment=.*/Comment=${dst_name} theme/" "$DST_DIR/$dst_name/index.theme"
        echo "Built GTK theme $dst_name ($to)"
    done
done

"$SCRIPT_DIR/make-bubblegum-icons.sh" "$accents"
