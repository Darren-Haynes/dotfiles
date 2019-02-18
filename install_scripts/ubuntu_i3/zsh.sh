#!/bin/bash

# Install Zsh, oh-my-zsh and link to aliases
sudo yes Y | apt install zsh
chsh -s $(which zsh) darren
aliases="$HOME/.aliases"
if [ ! -f "$aliases" ]; then
  ln -s "$HOME/dotfiles/aliases" "$HOME/.aliases"
  else
    echo "Aliases file already exists"
fi


oh_my="$HOME/.oh-my-zsh"
if [ ! -d "$oh_my" ]; then
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  else
    echo "Oh-my-zsh already installed"
fi

#Use my zsh config
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
ln -s "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"
