#!/bin/bash

# Install restricted extras
yes Y | echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula \
  select true | sudo debconf-set-selections
apt install ubuntu-restricted-extras

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

# Install Zsh and oh-my-zsh
  zsh \

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
