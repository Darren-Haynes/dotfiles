#!/bin/env/ bash
label=""
signal_strength=$(nmcli dev wifi | grep \* |  awk 'FNR == 2 {print $7}'
color=$(xrdb -query | grep '*color3'| awk '{print $NF}')
echo "<span foreground=\""$color"\">"$label$signal_strength"</span>"
