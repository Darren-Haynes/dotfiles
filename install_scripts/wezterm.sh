#!/bin/bash

os=$(grep -E ^ID= /etc/os-release)

mkdir $HOME/.tmpwezterm
tmpDir="$HOME/.tmpwezterm"
cd "$tmpDir"
dlAddr=https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage
AppImage=WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage

if [ "$os" == "ID=debian" ]; then
  echo "Installing wezterm"
 #    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
 #    if [ -d "$HOME/.config/kitty" ]; then
	# rm -r $HOME/.config/kitty
 #    fi
 #    ln -s $HOME/Dotfiles/kitty $HOME/.config/
  curl -LO "$dlAddr"
  chmod +x "$AppImage"
  sudo mv "$AppImage" /usr/local/bin/wezterm
fi

rm -r "$tmpDir"

