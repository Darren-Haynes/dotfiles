#!/bin/bash


# Install i3wm, xinit, xorg and compositor
sudo yes Y | apt install \
  i3-wm \
  i3status \
  dmenu \
  compton \
  xorg \
  xinit

# Install fonts
 sudo yes Y | apt install \
  xfonts-100dpi \
  xfonts-75dpi \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline

# Install drivers
sudo yes Y | apt install \
  mesa-utils \
  mesa-utils-extra \

# Install audio
sudo yes Y | apt install \
  alsa-utils \
  alsa-base \
  pulseaudio \

# Install restricted extras
sudo yes Y | echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo yes Y | apt install ubuntu-restricted-extras

# Install Zsh, oh-my-zsh and link to aliases
sudo yes Y | apt install zsh
chsh -s $(which zsh) darren
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
ln -s "$HOME/dotfiles/aliases" "$HOME/.aliases"
sed -i s'#ZSH_THEME="robbyrussell"#ZSH_THEME="candy-kingdom"#' ~/.zshrc
if grep -Fxq "source /home/darren/.aliases" "$HOME/.zshrc"
then
    echo "Aliases are already sourced in .zshrc file"
else
    echo "source $HOME/.aliases" >> ~/.zshrc
fi

# Install Editors
sudo yes Y | apt install \
  vim-nox \

# Install Firefox
sudo yes Y | apt install \
  libcanberra-pulse \
  firefox \

# Install Terminal Apps
sudo yes Y | apt install \
  htop \

# Configure Bashrc
sed -i s'/.bash_aliases/.aliases/' "$HOME/.bashrc"

# Install Termite
cd
mkdir git_programs
cd git_programs
git clone https://github.com/Corwind/termite-install.git
cd
sh "$HOME/git_programs/termite-install/termite-install.sh"

# Install polybar
sudo yes Y | apt install \
    cmake \
    pkg-config \
    libxcb1-dev \
    libxcb-util0-dev \
    libxcb-randr0-dev \
    python-xcbgen \
    xcb-proto \
    libxcb-image0-dev \
    libxcb-ewmh-dev \
    libxcb-xkb-dev \
    libxcb-xrm-dev \
    libxcb-cursor-dev \
    libasound2-dev \
    libpulse-dev \
    libjsoncpp-dev \
    libmpdclient-dev \
    libcurl4-openssl-dev \
    libiw-dev \
    libnl-3-dev \

cd ~/git_programs
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install
