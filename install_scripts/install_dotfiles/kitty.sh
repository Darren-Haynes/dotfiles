#!/bin/bash

os=$(grep -E ^ID= /etc/os-release)

if [[ "$os" = "ID=elementary" || "$os" == "ID=ubuntu" ]]; then
    sudo apt-get update
    CURL="$(which curl)"
    $CURL -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
    # your PATH)
    mkdir -p "$HOME/.local/bin/"
    ln -s "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/"

    # Place the kitty.desktop file somewhere it can be found by the OS
    cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications"

    # Update the path to the kitty icon in the kitty.desktop file
    sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop

    ln -s "$HOME/dotfiles/kitty/kitty-color-schemes" "$HOME/.config/kitty/"
    ln -s "$HOME/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/"
fi

if [[ "$os" = "ID=kali" || "$os" == "ID=debian" ]]; then
    sudo apt-get install kitty
    ln -s "$HOME/dotfiles/kitty/kitty-color-schemes" "$HOME/.config/kitty/"
    ln -s "$HOME/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/"
fi
