#!/bin/bash

zshrc="$HOME/.zshrc"
zshrc_dot="$HOME/dotfiles/zsh/zshrc"

if [ -L "$zshrc" ]; then
    # mv "$zshrc" "$zshrc".b4dotfiles
    if [ "$(readlink "$zshrc")" = "$zshrc_dot" ]; then
        echo "Correct symlink $zshrc --> $zshrc_dot already exists"

    else
        rm "$zshrc"
        ln -s "$zshrc_dot" "$zshrc"
        echo "Incorrect symlink fixed for $zshrc"
    fi
    chsh -s "$(which zsh)"
fi

if [ -f "$zshrc" ]; then
    mv "$zshrc" "$zshrc".b4dotfiles
    ln -s "$zshrc_dot" "$zshrc"

    else
        ln -s "$zshrc_dot" "$zshrc"
    chsh -s "$(which zsh)"
fi

# Link .zshenv to dotfiles version of zshenv
zshenv="$HOME/.zshenv"
zshenv_dot="$HOME/dotfiles/zsh/zshenv"

if [ -L "$zshenv" ]; then
    # mv "$zshenv" "$zshenv".b4dotfiles
    if [ "$(readlink "$zshenv")" = "$zshenv_dot" ]; then
        echo "Correct symlink $zshenv --> $zshenv_dot already exists"

    else
        rm "$zshenv"
        ln -s "$zshenv_dot" "$zshenv"
        echo "Incorrect symlink fixed for $zshenv"
    fi
    chsh -s "$(which zsh)"
    exit 0
fi

if [ -f "$zshenv" ]; then
    mv "$zshenv" "$zshenv".b4dotfiles
    ln -s "$zshenv_dot" "$zshenv"

    else
        ln -s "$zshenv_dot" "$zshenv"
    chsh -s "$(which zsh)"
fi


