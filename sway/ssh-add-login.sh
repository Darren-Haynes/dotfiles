#!/bin/bash
# Load ~/.ssh/id_ed25519 into the login session's ssh-agent (the one lightdm
# starts around sway, so every terminal/app inherits the same SSH_AUTH_SOCK).
# Prompts once per login via rofi. Does nothing if the key is already loaded.

KEY="$HOME/.ssh/id_ed25519"
[ -r "$KEY" ] || exit 0
[ -n "$SSH_AUTH_SOCK" ] || exit 0

fp=$(ssh-keygen -lf "$KEY.pub" 2>/dev/null | awk '{print $2}')
if [ -n "$fp" ] && ssh-add -l 2>/dev/null | grep -qF "$fp"; then
    exit 0
fi

SSH_ASKPASS="$HOME/Dotfiles/sway/ssh-askpass-rofi.sh" \
SSH_ASKPASS_REQUIRE=force \
    ssh-add -q "$KEY" </dev/null
