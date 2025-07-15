#!/bin/bash

set -eu

total=$(free -h | grep Mem | awk '{print $2}')
used=$(free -h | grep Mem | awk '{print $3}')
free=$(free -h | grep Mem | awk '{print $4}')
icon="$HOME/Dotfiles/icons/ram.png"
dunstify --timeout=9000 --icon="$icon" "Memory Stats" "Total: $total \nUsed: $used \nFree: $free"
