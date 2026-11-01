#!/bin/bash
# SSH_ASKPASS helper: asks for the key passphrase with a rofi password box.
# Used by ssh-add-login.sh when there is no terminal to type into.
# ssh-add passes its prompt as $1; print the passphrase on stdout.

exec rofi -dmenu -password -no-fixed-num-lines \
    -p "SSH passphrase" \
    -theme bubblegum \
    -theme-str 'listview { enabled: false; }' \
    -theme-str 'window { width: 500px; }' \
    < /dev/null
