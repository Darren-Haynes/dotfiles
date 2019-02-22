#!/bin/bash

echo ' ____  _______     __  ____  _____ _____ _   _ ____'
echo '|  _ \| ____\ \   / / / ___|| ____|_   _| | | |  _ \'
echo '| | | |  _|  \ \ / /  \___ \|  _|   | | | | | | |_) |'
echo '| |_| | |___  \ V /    ___) | |___  | | | |_| |  __/'
echo '|____/|_____|  \_/    |____/|_____| |_|  \___/|_|'
echo -e '\n'

# Install fonts
echo -e "\n---INSTALLING FONTS---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/fonts.sh"

# Install Neovim
echo -e "\n---INSTALLING NEOVIM---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/neovim.sh"

#Install some favorite apps
echo -e "\n---INSTALLING FAVORITE APPS---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/apps.sh"

#Install ranger
echo -e "\n---INSTALLING RANGER FILE MANAGER---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/ranger.sh"

# Make symlinks for my dotfiles
echo -e "\n---CREATING SYMLINKS FOR DOTFILES---"
python3 "$HOME/dotfiles/install_scripts/install_dotfiles/symlinks.py"

# Install tmux
echo -e "\n---INSTALLING TMUX---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/tmux.sh"

# Install zsh and oh-my-zsh
echo -e "\n---INSTALLING ZSH & OH-MY-ZSH---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/zsh.sh"
echo -e "\n---COMPLETING ZSH INSTALL---"
/bin/bash "$HOME/dotfiles/install_scripts/install_dotfiles/finish_zsh.sh"

echo ' ___           _        _ _    ____                      _      _'
echo '|_ _|_ __  ___| |_ __ _| | |  / ___|___  _ __ ___  _ __ | | ___| |_ ___'
echo ' | ||  _ \/ __| __/ _` | | | | |   / _ \|  _ ` _ \|  _ \| |/ _ \ __/ _ \'
echo ' | || | | \__ \ || (_| | | | | |__| (_) | | | | | | |_) | |  __/ ||  __/'
echo '|___|_| |_|___/\__\__,_|_|_|  \____\___/|_| |_| |_| .__/|_|\___|\__\___|'
echo '                                                  |_|'
echo -e '\n'
