#!/bin/bash

set -eu

brightness=$(xrandr --verbose | grep Brightness | awk '{print $2}')

if [[ "$brightness" == "1.0" ]]; then
  brightness="100"
else
  brightness=$(cut -c 3-4 <<<"$brightness")
fi

icon="$HOME/Dotfiles/icons/brightness.png"
dunstify --timeout=3000 --icon="$icon" "Brightness" "$brightness%"
