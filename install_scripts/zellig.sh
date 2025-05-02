#!/bin/bash

if [ ! -d "$HOME/.config/zellij/plugins" ]; then
  mkdir -p "$HOME/.config"
fi

cd "$HOME/Downloads/" || exit
curl -o zellij.tar.gz https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
tar -xf zellij.tar.gz
sudo mv zellij /usr/local/bin
