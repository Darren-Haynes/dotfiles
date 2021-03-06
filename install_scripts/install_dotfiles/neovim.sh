#!/bin/bash

# Install and configure Neovim
sudo apt install \
  software-properties-common \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \


os=$(grep -E ^ID= /etc/os-release)

if [[ "$os" = "ID=elementary" || "$os" == "ID=ubuntu" ]]; then
    echo "Ubuntu base operating system detected - installing PPA"
    sudo apt-add-repository ppa:neovim-ppa/stable
fi
sudo apt-get update
sudo apt install vim-scripts
sudo apt install shellcheck # Bash linter
sudo apt install neovim

undo_dir="$HOME/.vim/undodir"
if [ ! -d "$undo_dir" ]; then
  mkdir -p "$HOME/.vim/undodir"
  echo "$HOME/.vim/undodir directory created."
  else
    echo "Skip making $HOME/.vim/undodir, directory already exists."
fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

pip install neovim
pip3 install neovim

# Install after dir for ftplugins
after_dir="$HOME/.vim/after"
if [ ! -d "$after_dir" ]; then
  ln -s "$HOME/dotfiles/vim/after/" "$HOME/.vim/after"
  echo "$HOME/.vim/after symlink created for ftplugins."
  else
    echo "Skip linking $HOME/.vim/after, directory already exists."
fi

# Install universal ctags
sudo apt install autoconf
git clone https://github.com/universal-ctags/ctags.git
ctags_dir="$HOME/ctags"
"./$ctags_dir/autogen.sh"
"./$ctags_dir/configure.sh"
cd "$ctags_dir"
make
sudo make install
cd "$HOME"
sudo rm -rf "$ctags_dir"
