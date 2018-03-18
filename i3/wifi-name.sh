#!/bin/env/ bash
label=""
#signal="$signal_strength"
connection=$(nmcli connection show | grep wlp | awk '{print $1}')
signal_strength=$(nmcli dev wifi | grep "$connection" |  awk 'FNR == 2 {print $7}')
colon=":"
percent="%"
color=$(xrdb -query | grep '*color3'| awk '{print $NF}')
echo "<span foreground=\""$color"\">"$label$connection$colon$signal_strength$percent"</span>"
