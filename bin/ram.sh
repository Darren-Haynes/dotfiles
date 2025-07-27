#!/bin/bash

set -eu

total=$(free -h | grep Mem | awk '{print $2}')
total=${total::-1}
used=$(free -h | grep Mem | awk '{print $6}')
used=${used::-1}
cached=$(free -h | grep Mem | awk '{print $3}')
cached=${cached::-1}
free=$(free -h | grep Mem | awk '{print $4}')
free=${free::-1}
icon="$HOME/Dotfiles/icons/ram.png"
dunstify --timeout=9000 --icon="$icon" "Memory Stats" "Total: $total \nUsed: $used\n Cached: $cached \nFree: $free"
