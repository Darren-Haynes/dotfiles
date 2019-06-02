#!/bin/bash

# Install Zsh & oh-my-zsh

sudo apt install zsh-syntax-highlighting
sudo apt install zsh
chsh -s "$(which zsh)" "$USER"

oh_my="$HOME/.oh-my-zsh"
if [ ! -d "$oh_my" ]; then
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  else
    echo "Oh-my-zsh already installed"
fi
