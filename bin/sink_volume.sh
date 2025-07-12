#!/bin/bash

set -eu

percent=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print substr($5, 1, length($5)-1)}')
int_volume=$((volume))
icon="$HOME/Dotfiles/icons/volume-max.png"
if [ $int_volume -eq 0 ]; then
  icon="$HOME/Dotfiles/icons/volume-off.png"
elif [ $int_volume -lt 35 ]; then
  echo "YEPPERS"
  icon="$HOME/Dotfiles/icons/volume-low.png"
elif [ $int_volume -lt 75 ]; then
  echo "YEPPERS"
  icon="$HOME/Dotfiles/icons/volume-half.png"
fi

dunstify --timeout=3000 --icon="$icon" "Volume" "$volume"
echo $int_volume
