#!/bin/bash

os=$(grep -E ^ID= /etc/os-release)

mkdir $HOME/.tmpwezterm
tmpDir="$HOME/.tmpwezterm"
cd "$tmpDir"
dlAddr=https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage
AppImage=WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage

if [ "$os" == "ID=debian" ]; then
  printf "Installing wezterm"
  curl -LO "$dlAddr"
  chmod +x "$AppImage"
  sudo mv "$AppImage" /usr/local/bin/wezterm

  srcFile="$HOME/Dotfiles/wezterm/wezterm.lua"
  destFile="$HOME/.wezterm.lua"

  if [ -f "$destFile" ]; then
    rm "$destFile"
  fi

  ln -s "$srcFile" "$destFile"
fi

rm -r "$tmpDir"

