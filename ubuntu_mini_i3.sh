#!/bin/bash


# Install i3wm, xinit, xorg and compositor
yes Y | apt install \
  i3-wm \
  i3status \
  dmenu \
  compton \
  xorg \
  xinit

# Install fonts
yes Y | apt install \
  xfonts-100dpi \
  xfonts-75dpi \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline

# Install drivers
yes Y | apt install \
  mesa-utils \
  mesa-utils-extra \

# Install audio
yes Y | apt install \
  alsa-utils \
  alsa-base \
  pulseaudio \

# Install restricted extras
yes Y | echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
yes Y | apt install ubuntu-restricted-extras

# Install Zsh, oh-my-zsh and link to aliases
yes Y | apt install zsh
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
ln -s ~/dotfiles/aliases ~/.aliases
sed -i s'/ZSH_THEME="robbyrussell"/ZSH_THEME="candy-kingsom"' ~/.zshrc
echo "source $HOME/.aliases" >> ~/.zshrc

# Install Editors
yes Y | apt install \
  vimnox \

# Install Firefox
yes Y | apt install \
  libcanberra-pulse \
  firefox \

# Install Terminal Apps
yes Y | apt install \
  htop \
