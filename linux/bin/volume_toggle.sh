#!/bin/bash

set -eu

muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
state="on"
icon="$HOME/Dotfiles/icons/volume-max.png"

if [[ $muted == "yes" ]]; then
  state="off"
  icon="$HOME/Dotfiles/icons/volume-off.png"

fi

dunstify --timeout=3000 --icon="$icon" "Toggle State:" "$state"
