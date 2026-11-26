#!/bin/bash
# Build the generated GTK3/GTK4 themes for every family + accent:
#   Bubblegum: Blue, Green, Mono   (pink is the source theme itself in themes/)
#   Shhhed:    Green (default), Blue, Rose, Mono
# each in dark and light, into ~/.local/share/themes/. They are copies of
# themes/Bubblegum and themes/"Bubblegum Light" with every palette colour
# remapped (see gtk_remap_pairs in theme-palette.sh), so edit those source
# themes and re-run this script. The folder icon themes are built by
# make-theme-icons.sh, which this script also calls.
#
# Usage: make-theme-accents.sh [family [accent ...]]
#   no arguments        every family, every accent
#   family              every accent of that family
#   family accent ...   just those accents

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=theme-palette.sh
. "$SCRIPT_DIR/theme-palette.sh"

SRC_DIR="$(cd "$SCRIPT_DIR/../themes" && pwd)"
DST_DIR="$HOME/.local/share/themes"
mkdir -p "$DST_DIR"

families="${1:-$THEME_FAMILIES}"
[ $# -gt 0 ] && shift

for family in $families; do
    accents="${*:-$(theme_accents "$family")}"
    for accent in $accents; do
        # Bubblegum's default accent (pink) is the checked-in source theme.
        if [ "$family" = bubblegum ] && [ "$accent" = pink ]; then continue; fi
        for variant in dark light; do
            src_name="$(gtk_theme_name bubblegum "$variant" pink)"
            dst_name="$(gtk_theme_name "$family" "$variant" "$accent")"

            rm -rf "${DST_DIR:?}/$dst_name"
            cp -a "$SRC_DIR/$src_name" "$DST_DIR/$dst_name"

            # One pass over every css file so a colour that was just written is
            # never remapped a second time.
            pairs="$(gtk_remap_pairs "$family" "$variant" "$accent")"
            PAIRS="$pairs" find "$DST_DIR/$dst_name" -name '*.css' -exec perl -pi -e '
                BEGIN {
                    for (split /\n/, $ENV{PAIRS}) { my ($f, $t) = split / /; $map{lc $f} = $t; }
                    $re = join "|", map { quotemeta } keys %map;
                }
                s/($re)(?![0-9a-fA-F])/$map{lc $1}/gi;
            ' {} +

            comment="$dst_name theme"
            sed -i "s/^Name=.*/Name=${dst_name}/; s/^Comment=.*/Comment=${comment}/" "$DST_DIR/$dst_name/index.theme"
            echo "Built GTK theme $dst_name ($(accent_color "$family" "$variant" "$accent"))"
        done
    done
    "$SCRIPT_DIR/make-theme-icons.sh" "$family" $accents
done
