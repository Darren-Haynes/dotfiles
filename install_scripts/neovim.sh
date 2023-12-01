#!/bin/bash

# Install and configure Neovim
os=$(grep -E ^ID= /etc/os-release)

mkdir $HOME/.tmp
tmpDir=$HOME/.tmp
configSrc=$HOME/Dotfiles/nvim/init.lua
configDest=$HOME/.config/nvim/lua/custom/
nvimUrl=https://github.com/neovim/neovim/releases/download/v0.9.4/nvim.appimage
py3_11_6_URL=https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tar.xz

if [[ "$os" = "ID=debian" ]]; then

  printf "Installing Python 3.11.6 for neovim pynvim executable"
  sudo apt-get install -y build-essential
  sudo apt-get install -y libssl-dev
  sudo apt-get install -y libsqlite3-dev
  sudo apt-get install -y libbz2-dev
  sudo apt-get install -y libgdbm-dev
  sudo apt-get install -y libncurses5-dev
  sudo apt-get install -y libncursesw5-dev
  sudo apt-get install -y libreadline-dev
  sudo apt-get install -y zlib1g-dev
  sudo apt-get install -y libffi-dev

  wget -P $tmpDir $py3_11_6_URL
  cd "$tmpDir/Python-3.11.6/"
  tar -xf Python-3.11.6.tar.xz
  ./configure --enable-optimizations
  make -j $(nproc)
  sudo make altinstall -y
  python3.11 -m pip install pynvim

  printf "Installing Neovim for Debian"
  sudo apt-get install -y xsel  # clipboard support
  printf "$tmpDir"
  printf "$nvimUrl"
  wget -P $tmpDir $nvimUrl
  chmod u+x "$tmpDir/nvim.appimage"
  sudo mv "$tmpDir/nvim.appimage" /usr/local/bin
  printf "Neovim v0.9.4 has been install to /usr/local/bin"
  
  if [ -f "$configDest/init.lua" ]; then
    rm "$configDest/inig.lua"
  fi

  printf "Linking $configSrc --> $configDest"
  ln -s $configSrc $configDest
  rm -rf $tmpDir
fi

