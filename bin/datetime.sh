#!/bin/bash

set -eu

date=$(date)
icon="$HOME/Dotfiles/icons/datetime.png"
echo "$date" | xclip
echo "$date" | xclip -sel clip
dunstify --timeout=9000 --icon="$icon" "Date & Time" "$date"
