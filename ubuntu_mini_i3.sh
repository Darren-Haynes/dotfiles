#!/bin/bash


# Install i3wm, xinit, xorg and compositor
sudo yes Y | apt install \
  i3-wm \
  dmenu \
  compton \
  xorg \
  xinit
mkdir -p "$HOME/.config/i3"
ln -s "$HOME/dotfiles/i3/config" "$HOME/.config/i3/config"

# Install fonts
sudo yes Y | apt install \
  xfonts-100dpi \
  xfonts-75dpi \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline \
  fonts-font-awesome \

mkdir "$HOME/.fonts"
cd .fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SpaceMono.zip
sudo yes Y | apt install dtrx
dtrx SpaceMono.zip
fc-cache -fv
cd

# Install drivers
sudo yes Y | apt install \
  mesa-utils \
  mesa-utils-extra \

# Install audio
sudo yes Y | apt install \
  alsa-base \
  pulseaudio

# Install restricted extras
sudo yes Y | echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo yes Y | apt install ubuntu-restricted-extras

# Install and configure Neovim
sudo yes Y | apt install \
  software-properties-common \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \


sudo yes Y | apt-add-repository ppa:neovim-ppa/stable
sudo yes Y | apt-get update
sudo yes Y | apt install neovim
mkdir -p "$HOME/.vim/autoload/"
ln -s "$HOME/dotfiles/vim/vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config/nvim"
sudo yes Y | mkdir "$HOME/.vim/undodir"
ln -s "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Chrome
sudo yes Y | apt install gdebi-core
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo yes Y | gdebi google-chrome-stable_current_amd64.deb
sudo yes Y | rm google-chrome-stable_current_amd64.deb

# Configure Bashrc
#sed -i s'/.bash_aliases/.aliases/' "$HOME/.bashrc"
#ln -s ~/dotfiles/aliases ~/.aliases

# Install Termite
git clone https://github.com/Corwind/termite-install.git
./termite-install/termite-install.sh
sudo yes Y | rm -rf termite termite-install vte-ng
ln -s "$HOME/dotfiles/termite" "$HOME/.config/"

#Install Rofi
sudo yes Y | apt install rofi

# Install polybar
sudo yes Y | apt install \
    cmake \
    libxcb1-dev \
    libxcb-util0-dev \
    python-xcbgen \
    xcb-proto \
    libxcb-image0-dev \
    libxcb-ewmh-dev \
    libxcb-icccm4-dev \
    libxcb-xkb-dev \
    libxcb-xrm-dev \
    libxcb-cursor-dev \
    libasound2-dev \
    libpulse-dev \
    libjsoncpp-dev \
    libmpdclient-dev \
    libcurl4-openssl-dev \
    libiw-dev \
    libnl-3-dev

git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install
cd
rm -rf polybar
ln -s "$HOME/dotfiles/polybar" "$HOME/.config/polybar"
ln -s "$HOME/dotfiles/networkmanager-dmenu" "$HOME/.config/networkmanager-dmenu"

#Create bin folder
ln -s "$HOME/dotfiles/bin" "$HOME/bin"

#i3 Gaps
sudo yes Y | apt install \
    libxcb-keysyms1-dev \
    libyajl-dev \
    linstartup-notification0-dev \
    libev-dev \
    libxcb-xinerama0-dev \
    libxcbcommon-x11-dev

git clone https://www.github.com/Airblader/i3
cd i3
autreconf --force --install
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
cd
rm -rf i3

sudo yes Y | apt install feh clementine
sudo yes Y | apt update
sudo yes Y | apt upgrade

# Install Zsh, oh-my-zsh and link to aliases
sudo yes Y | apt install zsh
chsh -s $(which zsh) darren
ln -s "$HOME/dotfiles/aliases" "$HOME/.aliases"
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
ln -s "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


