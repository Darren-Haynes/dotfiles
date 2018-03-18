#!/bin/env/ bash
#calender=""
#getdate=$(date '+%a-%b-%d > %H:%M  ')
getdate=$(date '+%a-%b-%d > %H:%M  ')
date="$calender$getdate"
color=$(xrdb -query | grep '*color3'| awk '{print $NF}')
echo "<span foreground=\""$color"\">"$getdate"</span>"
