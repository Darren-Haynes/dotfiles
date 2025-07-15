#!/bin/bash

set -eu

time=$(date +"%r")
icon="$HOME/Dotfiles/icons/blue-clock.png"
echo "$time" | xclip
echo "$time" | xclip -sel clip
dunstify --timeout=9000 --icon="$icon" "Time: 12h" "$time"
