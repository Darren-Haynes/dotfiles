#!/bin/bash
#scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $HOME/.bash_scripts/lock_screen-0.png ]] && convert $HOME/.bash_scripts/aquarium-laptop.png $HOME/.bash_scripts/lock_screen-0.png -gravity center -composite -matte $HOME/.bash_scripts/aquarium-laptop.png
#i3lock -u -i /tmp/screen.png
i3lock -i /home/darren/.bash_scripts/aquarium-laptop.png
