#!/bin/bash

set -eu

date=$(date)
echo "$date" | xclip
echo "$date" | xclip -sel clip
dunstify --timeout=9000 "Date & Time" "$date"
