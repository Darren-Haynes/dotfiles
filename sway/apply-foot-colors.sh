#!/bin/bash
# Apply the foot colours for a theme family + variant + accent.
#   apply-foot-colors.sh <family> <dark|light> <accent>
#
# 1. Writes ~/.local/state/foot/theme.ini (included by foot/foot.ini): the
#    initial-color-theme plus foot/colors-<family>.ini, so NEW terminals open
#    with the right palette.
# 2. Pushes the same palette to RUNNING terminals with OSC escape sequences
#    written to each foot child's pty (foot reads its config once; its
#    USR1/USR2 signals can only flip between sections it already loaded).

DOTFILES="$HOME/Dotfiles"
# shellcheck source=../bash-scripts/theme-palette.sh
. "$DOTFILES/bash-scripts/theme-palette.sh"

family="$1"; variant="$2"; accent="$3"
src="$DOTFILES/foot/colors-$family.ini"
[ -f "$src" ] || { echo "no foot palette for family '$family'" >&2; exit 1; }
accent_hex=$(accent_color "$family" "$variant" "$accent")
accent_hex="${accent_hex#\#}"

state="${XDG_STATE_HOME:-$HOME/.local/state}/foot"
mkdir -p "$state"
tmp=$(mktemp "$state/theme.XXXXXX")
{
    printf '[main]\ninitial-color-theme=%s\n\n' "$variant"
    sed "s/@ACCENT@/${accent_hex}/g" "$src"
} > "$tmp"
mv -f "$tmp" "$state/theme.ini"

# Collect the active variant's colours from the section we just wrote.
declare -A c
section=""
while IFS= read -r line; do
    case "$line" in
        "[colors-$variant]") section=1; continue ;;
        "["*) section=""; continue ;;
    esac
    [ -n "$section" ] || continue
    case "$line" in
        *=*) c[${line%%=*}]="${line#*=}" ;;
    esac
done < "$state/theme.ini"

osc=""
for i in 0 1 2 3 4 5 6 7; do
    osc+=$(printf '\033]4;%d;#%s\033\\' "$i" "${c[regular$i]}")
    osc+=$(printf '\033]4;%d;#%s\033\\' "$((i + 8))" "${c[bright$i]}")
done
osc+=$(printf '\033]10;#%s\033\\\033]11;#%s\033\\' "${c[foreground]}" "${c[background]}")
cursor_bg="${c[cursor]#* }"
osc+=$(printf '\033]12;#%s\033\\' "$cursor_bg")
osc+=$(printf '\033]17;#%s\033\\\033]19;#%s\033\\' "${c[selection-background]}" "${c[selection-foreground]}")

for pid in $(pgrep -x foot); do
    for child in $(pgrep -P "$pid"); do
        tty=$(ps -o tty= -p "$child" | tr -d ' ')
        case "$tty" in
            pts/*) [ -w "/dev/$tty" ] && printf '%s' "$osc" > "/dev/$tty" ;;
        esac
    done
done
