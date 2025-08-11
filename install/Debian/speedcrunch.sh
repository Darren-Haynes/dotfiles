#!/bin/bash

if [ ! -d "$HOME/.config/Speedcrunch" ]; then 
    mkdir $HOME/.config/Speedcrunch
    ln -s $HOME/Dotfiles/SpeedCrunch/SpeedCrunch.ini $HOME/.config/Speedcrunch/
fi

sudo apt install -y speedcrunch	       # calculator

