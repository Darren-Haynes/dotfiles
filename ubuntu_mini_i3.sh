#!/bin/bash

yes | apt install -y ubuntu-restricted-extras
yes Y | apt install \
  xorg \
  xfonts-100dpi \
  xfonts-75dpi \
  mesa-utils \
  mesa-utils-extra \
  alsa-utils \
  alsa-base \
  pulseaudio \
  i3-wm \
  i3status \
  dmenu \
  compton \
  git \
  vimnox \
  fonts-dejavu \
  ttf-dejavu \
  zsh \
  htop \
  libcanberra-pulse \
  firefox \

