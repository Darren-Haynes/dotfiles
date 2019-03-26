#!/bin/bash
#scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $HOME/dotfiles/i3/lock.png ]] && convert $HOME/dotfiles/i3/aquarium-laptop.png $HOME/dotfiles/i3/lock.png -gravity center -composite -matte $HOME/dotfiles/i3/aquarium-laptop.png
#i3lock -u -i /tmp/screen.png
i3lock -i /home/darren/dotfiles/i3/aquarium-laptop.png --tiling
