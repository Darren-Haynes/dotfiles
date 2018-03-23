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

# Install Zsh and oh-my-zsh
yes Y | apt install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

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
