#!/bin/bash

set -eu

# Get total, used & available ram
total=$(df -h | grep /home | awk '{print $2}')
used=$(df -h | grep /home | awk '{print $3}')
available=$(df -h | grep /home | awk '{print $4}')

# text formating for notification
total_txt="Total: $total\n"
used_txt=" Used: $used\n"
avail_txt="Avail: $available"

# final text for notification
txt="$total_txt$used_txt$avail_txt"

# Notification icon
icon="$HOME/Dotfiles/icons/disk.png"

# Notification title
title="Home Disk"

# notification
dunstify --timeout=5000 --icon="$icon" "$title" "$txt"
