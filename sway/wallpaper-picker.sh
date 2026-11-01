#!/bin/bash
# Visual wallpaper picker: rofi thumbnail grid of ~/Pictures/Wallpaper.
# Uses only rofi, swaybg and ImageMagick (all already installed).
#   wallpaper-picker.sh           pick a wallpaper and apply it
#   wallpaper-picker.sh --restore apply the last choice (used at sway startup)

WALL_DIR="$HOME/Pictures/Wallpaper"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
CURRENT="$HOME/.local/state/current-wallpaper"   # symlink to the chosen image
DEFAULT="$WALL_DIR/pink-clouds.jpg"

apply() {
    pkill -x swaybg
    setsid -f swaybg -i "$1" -m fill >/dev/null 2>&1
}

if [ "$1" = "--restore" ]; then
    if [ -e "$CURRENT" ]; then apply "$CURRENT"; else apply "$DEFAULT"; fi
    exit 0
fi

mkdir -p "$THUMB_DIR" "$(dirname "$CURRENT")"

# Build/refresh square thumbnails (cached by name + mtime).
entries=""
while IFS= read -r -d '' img; do
    name=$(basename "$img")
    key=$(printf '%s' "$name" | md5sum | cut -c1-12)
    thumb="$THUMB_DIR/$key.png"
    if [ ! -f "$thumb" ] || [ "$img" -nt "$thumb" ]; then
        magick "$img" -thumbnail 400x400^ -gravity center -extent 400x400 "$thumb" 2>/dev/null
    fi
    entries+="${name%.*}\0icon\x1f${thumb}\n"
done < <(find "$WALL_DIR" -maxdepth 1 -type f \
            \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
            -print0 | sort -z)

[ -z "$entries" ] && { notify-send "Wallpaper picker" "No images in $WALL_DIR"; exit 1; }

choice=$(printf '%b' "$entries" | rofi -dmenu -i -show-icons -p "🖼️ Wallpaper" \
    -theme bubblegum \
    -theme-str 'window { width: 1700px; }
                listview { columns: 4; lines: 2; fixed-height: true; flow: horizontal; spacing: 14px; }
                element { orientation: vertical; padding: 10px; }
                element-icon { size: 18em; horizontal-align: 0.5; }
                element-text { horizontal-align: 0.5; }' \
    -format 'i' )

[ -z "$choice" ] && exit 0

# -format i returns the row index; map it back to the file name.
file=$(find "$WALL_DIR" -maxdepth 1 -type f \
            \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
            -print0 | sort -z | tr '\0' '\n' | sed -n "$((choice + 1))p")

[ -f "$file" ] || exit 1
ln -sfn "$file" "$CURRENT"
apply "$file"
