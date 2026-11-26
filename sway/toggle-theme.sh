#!/bin/bash
# Desktop theme switcher: family (Bubblegum / shhhed / Milo) x variant (dark / light) x accent.
#   toggle-theme.sh                  flip dark <-> light, keeping family and accent
#   toggle-theme.sh --family NAME    switch family (bubblegum | shhhed | milo); each family
#                                    remembers its own accent
#   toggle-theme.sh --accent NAME    switch accent within the current family
#   toggle-theme.sh --apply          re-apply the saved selection (e.g. at login)
#
# Updates: GTK theme, icon theme, color-scheme, sway window borders, waybar,
# rofi, dunst notification colors, foot (new and running terminals), btop, the
# Zed theme, the Brave theme directory, running vim/nvim sessions, and the
# GTK_THEME override used by xdg-desktop-portal-gtk (the file picker / print dialog).
# Generated GTK/icon themes (everything except Bubblegum pink) are built on first
# use by bash-scripts/make-theme-accents.sh.
# Colours live in bash-scripts/theme-palette.sh.

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

SCHEMA="org.gnome.desktop.interface"
STATE_DIR="$THEME_STATE_DIR"
mkdir -p "$STATE_DIR"

family=$(theme_current_family)
cur_variant=$(theme_current_variant)
variant="$cur_variant"

case "$1" in
    --family)
        case " $THEME_FAMILIES " in
            *" $2 "*) family="$2" ;;
            *) echo "Unknown family '$2' (choose: $THEME_FAMILIES)" >&2; exit 1 ;;
        esac
        ;;
    --accent)
        case " $(theme_accents "$family") " in
            *" $2 "*) printf '%s\n' "$2" > "$STATE_DIR/accent.$family" ;;
            *) echo "Unknown accent '$2' for $family (choose: $(theme_accents "$family"))" >&2; exit 1 ;;
        esac
        ;;
    --apply) ;;
    *)
        if [ "$cur_variant" = light ]; then variant=dark; else variant=light; fi
        ;;
esac

accent=$(theme_current_accent "$family")
printf '%s\n' "$family" > "$STATE_DIR/family"
printf '%s\n' "$accent" > "$STATE_DIR/accent.$family"

gtk_theme="$(gtk_theme_name "$family" "$variant" "$accent")"
icon_theme="$(icon_theme_name "$family" "$variant" "$accent")"
label="$(theme_family_label "$family")"

# Build the generated themes the first time they are needed.
if [ ! -d "$HOME/.local/share/themes/$gtk_theme" ] && [ ! -d "$DOTFILES/themes/$gtk_theme" ] \
   || [ ! -d "$HOME/.local/share/icons/$icon_theme" ]; then
    notify-send -t 4000 "Theme" "Building $label ($accent), one moment..." 2>/dev/null
    "$DOTFILES/bash-scripts/make-theme-accents.sh" "$family" "$accent" >/dev/null 2>&1
fi

if [ "$variant" = dark ]; then
    scheme="prefer-dark"
    notify_icon="weather-clear-night"
else
    scheme="prefer-light"
    notify_icon="weather-clear"
fi

gsettings set "$SCHEMA" gtk-theme "$gtk_theme"
gsettings set "$SCHEMA" icon-theme "$icon_theme"
gsettings set "$SCHEMA" color-scheme "$scheme"

# State files read by vim (polls `scheme` once a second) and nvim (on SIGUSR1).
printf '%s\n' "$variant" > "$STATE_DIR/scheme"

# sway window borders: accent on the focused window, neutral on the rest.
"$DOTFILES/sway/apply-sway-colors.sh" "$family" "$variant" "$accent"

# waybar: the bar is always dark, so it takes the dark shade of the accent from
# waybar/accent.css (imported by style.css); SIGUSR2 reloads its style.
"$DOTFILES/sway/waybar-accent.sh" "$accent"
pkill -SIGUSR2 -x waybar 2>/dev/null

# rofi (always dark): colours are imported from a generated file on each launch.
"$DOTFILES/sway/apply-rofi-colors.sh" "$family" "$accent"

# dunst notification colours + icon theme.
"$DOTFILES/sway/apply-dunst-colors.sh" "$family" "$variant" "$accent"

# foot: new windows read ~/.local/state/foot/theme.ini; running ones are
# recoloured live with OSC escape sequences.
"$DOTFILES/sway/apply-foot-colors.sh" "$family" "$variant" "$accent"

# btop reloads its theme on SIGUSR2.
"$DOTFILES/sway/apply-btop-theme.sh" "$family"

# Zed: ~/.config/zed/themes/desktop.json holds "Desktop Dark" / "Desktop Light"
# built from the family + accent; Zed hot-reloads it and picks the variant from
# the system colour-scheme set above.
"$DOTFILES/bash-scripts/make-zed-theme.py" "$family" "$accent"

# Brave: refresh the generated theme directory. A running Brave picks the new
# variant up on its next start (or Reload on brave://extensions).
"$DOTFILES/sway/apply-brave-theme.sh" "$family" "$variant"

# SpeedCrunch rewrites its ini on exit, so only touch it while it is closed.
if ! pgrep -x speedcrunch >/dev/null 2>&1; then
    sc_ini="$HOME/.config/SpeedCrunch/SpeedCrunch.ini"
    [ -f "$sc_ini" ] && sed -i "s/^Display\\\\ColorSchemeName=.*/Display\\\\ColorSchemeName=${family}-${variant}/" "$sc_ini"
fi

# nvim re-reads the colour-scheme and family on SIGUSR1 (neovim-bubblegum plugin);
# it ignores the signal harmlessly if the plugin isn't loaded. vim polls the
# state files above once a second (see vim/vimrc).
pkill -USR1 -x nvim 2>/dev/null

# GTK_THEME env overrides gsettings for anything systemd/dbus launches,
# so update it and restart the portal so the file picker follows the toggle.
systemctl --user set-environment GTK_THEME="$gtk_theme"
dbus-update-activation-environment --systemd GTK_THEME="$gtk_theme"
systemctl --user restart xdg-desktop-portal-gtk >/dev/null 2>&1

[ "$1" = --apply ] || notify-send -t 2500 -i "$notify_icon" "$label theme" "$variant / $accent  ($gtk_theme)" 2>/dev/null
