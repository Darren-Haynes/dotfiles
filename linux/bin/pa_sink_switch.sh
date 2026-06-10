#! /usr/bin/env bash

set -eu

# Get the ID for the current DEFAULT_SINK
defaultSink=$(pactl info | grep "Default Sink: " | awk '{ print $3 }')

# Query the list of all available sinks
sinks=()
i=0

while read -r line; do
  index=$(echo "$line" | awk '{ print $1 }')
  sinks[${#sinks[@]}]=$index

  # Find the current DEFAULT_SINK
  if grep -q "$defaultSink" <<<"$line"; then
    defaultPos=$i
  fi

  i=$(($i + 1))
done <<<"$(pactl list sinks short)"

# Compute the ID of the new DEFAULT_SINK
newDefaultPos=$((($defaultPos + 1) % ${#sinks[@]}))
newDefaultSink=${sinks[$newDefaultPos]}

# Update the DEFAULT_SINK
pacmd set-default-sink "$newDefaultSink"

# Notify change to default sink
sound=$(pactl info | grep "Default Sink: " | awk '{print $3 }')
echo "$sound"

razor='Razer'
dell='pci-0000_00_1'
bluetooth='D8_90_05_78_FB_12'

icon="$HOME/Dotfiles/icons/sound-icon-red.png"
if [[ "$sound" == *"$razor"* ]]; then
  sound="Razor BlackShark"
  icon="$HOME/Dotfiles/icons/headphones-razor.png"
fi
if [[ "$sound" == *"$dell"* ]]; then
  sound="Dell Monitor"
  icon="$HOME/Dotfiles/icons/monitor-speakers.png"
fi
if [[ "$sound" == *"$bluetooth"* ]]; then
  sound="JLab Go Air"
  icon="$HOME/Dotfiles/icons/bluetooth.png"
fi

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print substr($5, 1, length($5)-1)}')
volume_txt="Volume: $volume\n"
toggle_state=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
toggle_txt="Muted: $toggle_state"

dunstify --timeout=3000 --icon="$icon" "$sound" "$volume_txt $toggle_txt"

# Move all current playing streams to the new DEFAULT_SINK
while read -r stream; do
  # Check whether there is a stream playing in the first place
  if [ -z "$stream" ]; then
    break
  fi

  streamId=$(echo "$stream" | awk '{ print $1 }')
  pactl move-sink-input "$streamId" @DEFAULT_SINK@
done <<<"$(pactl list short sink-inputs)"
