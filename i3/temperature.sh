#!/bin/env/ bash
gettemp=$(acpi -t | awk '{print $4}')
cent=$(acpi -t | awk '{print $6}')
icon=""
temp="$icon$gettemp$cent"
color=$(xrdb -query | grep '*color3'| awk '{print $NF}')
echo "<span foreground=\""$color"\">"$temp"</span>"
