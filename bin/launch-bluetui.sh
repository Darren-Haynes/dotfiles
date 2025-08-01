#!/bin/bash

set -eu

width=$(xrandr --nograb --current | grep ^Screen | awk '{print $8}')
width=$((width / 2))   # half the width of screen
width=$((width - 260)) # minus half the width of bluetui terminal size
width=$((width - 370)) # minus the width of the keybindings image
width=$((width - 30))  # minus the gap size between image and terminal

height=$(xrandr --nograb --current | grep ^Screen | awk '{print $10}')
height=${height::-1} # get rid of trailing comma
height=$((height / 2))
height=$((height - 397)) # minus half the height of bluetui terminal size
# height=$((height - 370)) # minus the height of the keybindings image
# height=$((height - 30))  # minus the gap size between image and terminal

dimension="370x786+${width}+${height}"
bspc rule -a feh state=floating rectangle $dimension center=false
feh "$HOME/Dotfiles/images/bluetui-keybinds.png" &
xterm -e "ls -lrt;bluetui"
# bspc rule -a feh state=floating center=true
bspc rule -a feh state=tiled
