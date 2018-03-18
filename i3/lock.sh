#!/bin/bash

# grep xrandr to find if more than 1 display is connected
connected=$(xrandr | grep -c '\bconnected\b')

# lock screen with a different image depending if 1 display found or more than 1 found.
if [[ $connected -gt 1 ]];
then
	i3lock -i /home/darren/dotfiles/i3/aquarium.png
else
	i3lock -i /home/darren/dotfiles/i3/aquarium-laptop.png
fi
