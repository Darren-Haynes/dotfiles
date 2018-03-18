#!/bin/env/ bash
label=""
getbattery=$(acpi -i | head -1 | awk '{print $4}')
battery="$label$getbattery"
color=$(xrdb -query | grep '*color3'| awk '{print $NF}')
echo "<span foreground=\""$color"\">"$battery"</span>"

#digits_only=$(acpi -i | head -1 | awk '{print $4}' | grep -o '[0-9]*')
#if [ "$digits_only" -eq "20" ]; then
  #paplay /home/darren/Music/Sound_Bites/Electronic_Chime-KevanGC-495939803.wav
#fi

#if [ "$digits_only" -eq "10" ]; then
  #paplay /home/darren/Music/Sound_Bites/Electronic_Chime-KevanGC-495939803.wav
  #paplay /home/darren/Music/Sound_Bites/Electronic_Chime-KevanGC-495939803.wav
#fi

#if [ "$digits_only" -eq "6" ]; then
  #paplay /home/darren/Music/Sound_Bites/Grocery\ Scanning-SoundBible.com-1637675042.wav-KevanGC-495939803.wav
#fi
