#/bin/bash

zshrc="$HOME/.zshrc"
zshrc_dot="$HOME/dotfiles/zsh/zshrc"

if [ -L "$zshrc" ]; then
    # mv "$zshrc" "$zshrc".b4dotfiles
    if [ $(readlink "$zshrc") = "$zshrc_dot" ]; then
        echo "Correct symlink $zshrc --> $zshrc_dot already exists"

    else
        rm "$zshrc"
        ln -s "$zshrc_dot" "$zshrc"
        echo "Incorrect symlink fixed for $zshrc"
    fi
    exit 0
fi

if [ -f "$zshrc" ]; then
    mv "$zshrc" "$zshrc".b4dotfiles
    ln -s "$zshrc_dot" "$zshrc"

    else
        ln -s "$zshrc_dot" "$zshrc"
fi
