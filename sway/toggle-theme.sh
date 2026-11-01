#!/bin/bash
# Toggle Bubblegum dark/light: GTK theme, icon theme, color-scheme, and the
# GTK_THEME override used by xdg-desktop-portal-gtk (the file picker).

SCHEMA="org.gnome.desktop.interface"
current=$(gsettings get "$SCHEMA" gtk-theme | tr -d "'")

if [ "$current" = "Bubblegum Light" ]; then
    gtk_theme="Bubblegum"
    icon_theme="Colloid-Pink-Dark"
    scheme="prefer-dark"
else
    gtk_theme="Bubblegum Light"
    icon_theme="Colloid-Pink-Light"
    scheme="prefer-light"
fi

gsettings set "$SCHEMA" gtk-theme "$gtk_theme"
gsettings set "$SCHEMA" icon-theme "$icon_theme"
gsettings set "$SCHEMA" color-scheme "$scheme"

# GTK_THEME env overrides gsettings for anything systemd/dbus launches,
# so update it and restart the portal so the file picker follows the toggle.
systemctl --user set-environment GTK_THEME="$gtk_theme"
dbus-update-activation-environment --systemd GTK_THEME="$gtk_theme"
systemctl --user restart xdg-desktop-portal-gtk >/dev/null 2>&1

notify-send -t 1500 "Theme" "$gtk_theme / $icon_theme" 2>/dev/null
