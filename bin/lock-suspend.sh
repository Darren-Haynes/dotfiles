#!/bin/bash

set -eu

i3lock -e -i ~/Dotfiles/images/lock-screen.png
sleep 60
systemctl suspend
