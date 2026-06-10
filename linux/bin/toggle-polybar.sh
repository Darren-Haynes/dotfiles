#!/bin/bash

pgrep -x polybar
status=$?
if test $status -eq 0; then
  killall polybar && bspc config -m focused top_padding 0
else
  "$HOME/Dotfiles/bin/polybar-launch.sh" && bspc config -m focused top_padding 31
fi
