#!/bin/bash

set -eu

network_type=$(nmcli device | grep connected | grep -v loopback | awk '{print $2}')
network_name=$(nmcli device | grep connected | grep -v loopback | awk '{print $4}')
icon="$HOME/Dotfiles/icons/network-true.png"
dunstify --timeout=3000 --icon="$icon" "Network" "${network_type^}: $network_name"
