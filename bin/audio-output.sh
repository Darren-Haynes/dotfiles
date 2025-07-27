#! /usr/bin/env bash

set -eu

# Notify change to default sink
sound=$(pactl info | grep "Default Sink: " | awk '{print $3 }')

razor='Razer'
dell='pci-0000_00_1'
bluetooth='D8_90_05_78_FB_12'

icon="$HOME/Dotfiles/icons/sound-icon-red.png"
if [[ "$sound" == *"$razor"* ]]; then
  sound="Razor BlackShark"
  icon="$HOME/Dotfiles/icons/headphones-razor.png"
fi
if [[ "$sound" == *"$dell"* ]]; then
  sound="Dell Monitor Speakers"
  icon="$HOME/Dotfiles/icons/monitor-speakers.png"
fi
if [[ "$sound" == *"$bluetooth"* ]]; then
  sound="JLab Go Air Sport"
  icon="$HOME/Dotfiles/icons/bluetooth.png"
fi

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print substr($5, 1, length($5)-1)}')
volume_txt="Volume: $volume\n"
toggle_state=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
toggle_txt="Muted: $toggle_state"

dunstify --timeout=3000 --icon="$icon" "$sound" "$volume_txt $toggle_txt"
