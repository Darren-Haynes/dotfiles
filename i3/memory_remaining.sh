#!/bin/env/ bash
icon=""
percent="%"
getmemory=$(awk '/MemTotal/ {memtotal=$2}; /MemAvailable/ {memavail=$2}; END { printf("%.0f", memavail / memtotal * 100) }' /proc/meminfo)
freememory="$icon$getmemory$percent"
color=$(xrdb -query | grep '*color3'| awk '{print $NF}')
echo "<span foreground=\""$color"\">"$freememory"</span>"
