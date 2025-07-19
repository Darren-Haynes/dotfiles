#!/bin/bash

set -eu

icon1="$HOME/Dotfiles/icons/network-1.png"
icon2="$HOME/Dotfiles/icons/network-true.png"

status="$(systemctl status networking | grep Active | awk '{print $2}')"
if [ "$status" == "active" ]; then
  dunstify --timeout=9000 --icon="$icon1" "Network already active"
fi

dunstify --timeout=9000 --icon="$icon1" "Network restart intiated"

restart_not_complete=true
while [ "$restart_not_complete" ]; do
  sudo systemctl restart networking
  dunstify --timeout=9000 --icon="$icon2" "Network restart completed"
  wait 1
  status="$(systemctl status networking | grep Active | awk '{print $2}')"
  dunstify --timeout=9000 --icon="$icon2" "Network restart completed"
  if [ "$status" == "active" ]; then
    dunstify --timeout=9000 --icon="$icon2" "Network restart completed"
    restart_not_complete=false
  fi
  k
done
