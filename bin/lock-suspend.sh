#!/bin/bash

set -eu

# total=$(free -h | grep Mem | awk '{print $2}')
# total=${total::-1}
# used=$(free -h | grep Mem | awk '{print $6}')
# used=${used::-1}
# cached=$(free -h | grep Mem | awk '{print $3}')
# cached=${cached::-1}
# free=$(free -h | grep Mem | awk '{print $4}')
# free=${free::-1}
i3lock -e -i ~/Dotfiles/images/lock-screen.png
sleep 60
systemctl suspend
