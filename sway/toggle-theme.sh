#!/bin/bash
# Toggle Bubblegum dark/light: GTK theme, icon theme, color-scheme, dunst
# notification colors, foot terminals, running vim/nvim sessions, and the
# GTK_THEME override used by xdg-desktop-portal-gtk (the file picker).

SCHEMA="org.gnome.desktop.interface"
current=$(gsettings get "$SCHEMA" gtk-theme | tr -d "'")

if [ "$current" = "Bubblegum Light" ]; then
    gtk_theme="Bubblegum"
    icon_theme="Colloid-Bubblegum-Dark"
    scheme="prefer-dark"
    dunst_colors="colors-dark.conf"
    notify_icon="weather-clear-night"
    foot_theme="dark"
    foot_signal="USR1"
else
    gtk_theme="Bubblegum Light"
    icon_theme="Colloid-Bubblegum-Light"
    scheme="prefer-light"
    dunst_colors="colors-light.conf"
    notify_icon="weather-clear"
    foot_theme="light"
    foot_signal="USR2"
fi

gsettings set "$SCHEMA" gtk-theme "$gtk_theme"
gsettings set "$SCHEMA" icon-theme "$icon_theme"
gsettings set "$SCHEMA" color-scheme "$scheme"

# dunst: ~/.config/dunst/dunstrc.d/10-colors.conf -> Dotfiles/dunst/colors-*.conf
DUNST_SRC="$HOME/Dotfiles/dunst"
DUNST_CFG="$HOME/.config/dunst"
mkdir -p "$DUNST_CFG/dunstrc.d"
ln -sfn "$DUNST_SRC/dunstrc" "$DUNST_CFG/dunstrc"
ln -sfn "$DUNST_SRC/$dunst_colors" "$DUNST_CFG/dunstrc.d/10-colors.conf"
dunstctl reload 2>/dev/null

# foot: new windows read the state file via an include in foot.ini; running
# ones switch live on SIGUSR1 (dark) / SIGUSR2 (light).
FOOT_STATE="${XDG_STATE_HOME:-$HOME/.local/state}/foot"
mkdir -p "$FOOT_STATE"
printf '[main]\ninitial-color-theme=%s\n' "$foot_theme" > "$FOOT_STATE/theme.ini"
pkill "-$foot_signal" -x foot 2>/dev/null

# nvim re-reads the color-scheme on SIGUSR1 (neovim-bubblegum plugin); it
# ignores the signal harmlessly if the plugin isn't loaded. vim polls the state
# file below once a second (see vim/vimrc).
pkill -USR1 -x nvim 2>/dev/null
mkdir -p "$HOME/.local/state/bubblegum"
printf '%s\n' "$foot_theme" > "$HOME/.local/state/bubblegum/scheme"

# GTK_THEME env overrides gsettings for anything systemd/dbus launches,
# so update it and restart the portal so the file picker follows the toggle.
systemctl --user set-environment GTK_THEME="$gtk_theme"
dbus-update-activation-environment --systemd GTK_THEME="$gtk_theme"
systemctl --user restart xdg-desktop-portal-gtk >/dev/null 2>&1

notify-send -t 2500 -i "$notify_icon" "Theme" "$gtk_theme / $icon_theme" 2>/dev/null
