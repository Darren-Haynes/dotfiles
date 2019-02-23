#!/bin/bash

# Install tmux
sudo apt install tmux

# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# gpakosz conf files with my personal adjustments - especially color
conf_dot=$HOME/dotfiles/tmux/tmux.conf
local_conf_dot=$HOME/dotfiles/tmux/tmux.conf.local
tmux_dir_conf=$HOME/.tmux/.tmux.conf
conf=$HOME/.tmux.conf
local_conf=$HOME/.tmux.conf.local

# Link through 2 paths
ln -s "$conf_dot" "$tmux_dir_conf"
ln -s "$tmux_dir_conf" "$conf"

ln -s "$local_conf_dot" "$local_conf"
