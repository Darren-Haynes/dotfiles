#!/bin/bash


echo ' ____  _______     __  ____  _____ _____ _   _ ____'
echo '|  _ \| ____\ \   / / / ___|| ____|_   _| | | |  _ \'
echo '| | | |  _|  \ \ / /  \___ \|  _|   | | | | | | |_) |'
echo '| |_| | |___  \ V /    ___) | |___  | | | |_| |  __/'
echo '|____/|_____|  \_/    |____/|_____| |_|  \___/|_|'
echo '\n'

# echo "\n---Installing Fonts---"
# source "$HOME/dotfiles/install_scripts/fonts.sh"
echo "\n---Installing NEOVIM---"
source "$HOME/dotfiles/install_scripts/install_dotfiles/neovim.sh"
echo "\n---Installing FAVORITE APPS---"
source "$HOME/dotfiles/install_scripts/install_scripts/apps.sh"
echo "\n---Installing ZSH & Oh-my-zsh---"
source "$HOME/dotfiles/install_scripts/install_dotfiles/zsh.sh"
echo "\n---Creating symlinks for dotfiles---"
python3 "$HOME/dotfiles/install_scripts/install_dotfiles/symlinks.py"
