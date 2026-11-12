#!/bin/bash
# Bubblegum theme switcher: dark/light variant + accent colour (pink/blue/green/mono).
#   toggle-theme.sh                 flip dark <-> light, keeping the current accent
#   toggle-theme.sh --accent NAME   keep the current variant, switch accent
#   toggle-theme.sh --apply         re-apply the saved variant + accent (e.g. at login)
#
# Updates: GTK theme, icon theme, color-scheme, sway window borders, waybar,
# dunst notification colors, the Brave theme directory, foot
# terminals, running vim/nvim sessions, and the GTK_THEME override used by
# xdg-desktop-portal-gtk (the file picker / print dialog).
# Non-pink accents are generated copies of the themes; see
# bash-scripts/make-bubblegum-accents.sh (built automatically when missing).

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/bubblegum-accents.sh
. "$DOTFILES/bash-scripts/bubblegum-accents.sh"

SCHEMA="org.gnome.desktop.interface"
STATE_DIR="$HOME/.local/state/bubblegum"
mkdir -p "$STATE_DIR"

current=$(gsettings get "$SCHEMA" gtk-theme | tr -d "'")
case "$current" in
    "Bubblegum Light"*) cur_variant=light ;;
    *)                  cur_variant=dark ;;
esac
accent=$(cat "$STATE_DIR/accent" 2>/dev/null)
case " $BUBBLEGUM_ACCENTS " in *" $accent "*) ;; *) accent=pink ;; esac

case "$1" in
    --accent)
        case " $BUBBLEGUM_ACCENTS " in
            *" $2 "*) accent="$2" ;;
            *) echo "Unknown accent '$2' (choose: $BUBBLEGUM_ACCENTS)" >&2; exit 1 ;;
        esac
        variant="$cur_variant"
        ;;
    --apply)
        variant="$cur_variant"
        ;;
    *)
        if [ "$cur_variant" = light ]; then variant=dark; else variant=light; fi
        ;;
esac
printf '%s\n' "$accent" > "$STATE_DIR/accent"

gtk_theme="$(gtk_theme_name "$variant" "$accent")"
icon_theme="$(icon_theme_name "$variant" "$accent")"

# Build the generated accent themes the first time they are needed.
if [ ! -d "$HOME/.local/share/themes/$gtk_theme" ] && [ ! -d "$DOTFILES/themes/$gtk_theme" ] \
   || [ ! -d "$HOME/.local/share/icons/$icon_theme" ]; then
    notify-send -t 4000 "Theme" "Building the $accent accent, one moment..." 2>/dev/null
    "$DOTFILES/bash-scripts/make-bubblegum-accents.sh" "$accent" >/dev/null 2>&1
fi

if [ "$variant" = dark ]; then
    scheme="prefer-dark"
    dunst_colors="colors-dark.conf"
    notify_icon="weather-clear-night"
    foot_theme="dark"
    foot_signal="USR1"
else
    scheme="prefer-light"
    dunst_colors="colors-light.conf"
    notify_icon="weather-clear"
    foot_theme="light"
    foot_signal="USR2"
fi

gsettings set "$SCHEMA" gtk-theme "$gtk_theme"
gsettings set "$SCHEMA" icon-theme "$icon_theme"
gsettings set "$SCHEMA" color-scheme "$scheme"

# sway window borders: accent on the focused window, neutral on the rest.
"$DOTFILES/sway/apply-sway-colors.sh" "$variant" "$accent"

# Brave: refresh the generated theme directory. A running Brave picks the new
# variant up on its next start (or Reload on brave://extensions).
"$DOTFILES/sway/apply-brave-theme.sh" "$variant"

# waybar: the bar is always dark, so it takes the dark shade of the accent from
# waybar/accent.css (imported by style.css); SIGUSR2 reloads its style.
"$DOTFILES/sway/waybar-accent.sh" "$accent"
pkill -SIGUSR2 -x waybar 2>/dev/null

# dunst: ~/.config/dunst/dunstrc.d/10-colors.conf is generated from
# Dotfiles/dunst/colors-*.conf with the pink accent and icon theme swapped.
DUNST_SRC="$DOTFILES/dunst"
DUNST_CFG="$HOME/.config/dunst"
mkdir -p "$DUNST_CFG/dunstrc.d"
ln -sfn "$DUNST_SRC/dunstrc" "$DUNST_CFG/dunstrc"
src_icon="$(icon_theme_name "$variant" pink)"
rm -f "$DUNST_CFG/dunstrc.d/10-colors.conf"
sed "s/$(accent_color "$variant" pink)/$(accent_color "$variant" "$accent")/Ig; s/${src_icon}/${icon_theme}/g" \
    "$DUNST_SRC/$dunst_colors" > "$DUNST_CFG/dunstrc.d/10-colors.conf"
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
printf '%s\n' "$foot_theme" > "$STATE_DIR/scheme"

# GTK_THEME env overrides gsettings for anything systemd/dbus launches,
# so update it and restart the portal so the file picker follows the toggle.
systemctl --user set-environment GTK_THEME="$gtk_theme"
dbus-update-activation-environment --systemd GTK_THEME="$gtk_theme"
systemctl --user restart xdg-desktop-portal-gtk >/dev/null 2>&1

notify-send -t 2500 -i "$notify_icon" "Theme" "$gtk_theme / $icon_theme" 2>/dev/null
