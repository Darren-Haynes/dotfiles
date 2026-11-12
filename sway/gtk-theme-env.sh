#!/bin/sh
# Export the GTK theme currently chosen in gsettings to systemd/dbus, so
# portal dialogs (file picker, print dialog) match it after login. GTK_THEME
# overrides gsettings for anything systemd/dbus launches, so it must follow the
# saved variant + accent rather than being hard-coded.
theme=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
[ -n "$theme" ] || theme=Bubblegum
systemctl --user set-environment GTK_THEME="$theme"
dbus-update-activation-environment --systemd GTK_THEME="$theme"
