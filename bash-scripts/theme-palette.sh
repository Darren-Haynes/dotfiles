# Desktop theme palette. Sourced by make-theme-accents.sh, make-theme-icons.sh,
# sway/toggle-theme.sh, sway/accent-picker.sh and the sway/apply-*.sh helpers.
#
# Three independent axes:
#   family   bubblegum | shhhed
#   variant  dark | light
#   accent   per family (see theme_accents)
#
# Bubblegum's pink is the accent baked into the source themes in themes/.
# Every other combination (all of shhhed, plus Bubblegum's other accents) is a
# generated copy with the colours remapped by make-theme-accents.sh.
# "mono" is the neutral accent: near-white on dark, charcoal on light.

THEME_FAMILIES="bubblegum shhhed"
THEME_STATE_DIR="$HOME/.local/state/bubblegum"

theme_accents() {
    case "$1" in
        shhhed) echo "green blue rose mono" ;;
        *)      echo "pink blue green mono" ;;
    esac
}

theme_default_accent() {
    case "$1" in
        shhhed) echo green ;;
        *)      echo pink ;;
    esac
}

theme_family_label() {
    case "$1" in
        shhhed) echo "shhhed" ;;
        *)      echo "Bubblegum" ;;
    esac
}

# accent_color <family> <dark|light> <accent>  ->  hex colour
accent_color() {
    case "$1:$2:$3" in
        bubblegum:dark:pink)    echo "#d7afd7" ;;
        bubblegum:dark:blue)    echo "#87d7ff" ;;
        bubblegum:dark:green)   echo "#afd787" ;;
        bubblegum:dark:mono)    echo "#e8e8e8" ;;
        bubblegum:light:pink)   echo "#b060a0" ;;
        bubblegum:light:blue)   echo "#0088cc" ;;
        bubblegum:light:green)  echo "#357f55" ;;
        bubblegum:light:mono)   echo "#3a3a3a" ;;
        shhhed:dark:green)      echo "#6ca880" ;;
        shhhed:dark:blue)       echo "#729bcf" ;;
        shhhed:dark:rose)       echo "#ca8489" ;;
        shhhed:dark:mono)       echo "#e0e0e4" ;;
        shhhed:light:green)     echo "#2a7848" ;;
        shhhed:light:blue)      echo "#0050d8" ;;
        shhhed:light:rose)      echo "#b84e60" ;;
        shhhed:light:mono)      echo "#2a2a30" ;;
        *) return 1 ;;
    esac
}

# theme_color <family> <dark|light> <role>  ->  hex colour
# Roles (named after how the GTK themes use them):
#   bg      window background        base    entries, sidebars, lists
#   raised  headerbars, tooltips     border  separators, borders
#   hover   hover background         fg      normal text
#   muted   secondary text           dim     disabled / placeholder text
#   strong  emphasised text          error   errors, urgent
#   inactive  unfocused window border
#   critical_bg  background tint for critical notifications
theme_color() {
    case "$1:$2:$3" in
        bubblegum:dark:bg)       echo "#2a2a2a" ;;
        bubblegum:dark:base)     echo "#303030" ;;
        bubblegum:dark:raised)   echo "#3a3a3a" ;;
        bubblegum:dark:border)   echo "#454545" ;;
        bubblegum:dark:hover)    echo "#454545" ;;
        bubblegum:dark:fg)       echo "#d7d7d7" ;;
        bubblegum:dark:muted)    echo "#a7a7a7" ;;
        bubblegum:dark:dim)      echo "#808080" ;;
        bubblegum:dark:strong)   echo "#ffffff" ;;
        bubblegum:dark:error)    echo "#d78787" ;;
        bubblegum:dark:inactive) echo "#222222" ;;
        bubblegum:light:bg)      echo "#f5f5f5" ;;
        bubblegum:light:base)    echo "#ececec" ;;
        bubblegum:light:raised)  echo "#e0e0e0" ;;
        bubblegum:light:border)  echo "#c8c8c8" ;;
        bubblegum:light:hover)   echo "#d5d5d5" ;;
        bubblegum:light:fg)      echo "#2a2a2a" ;;
        bubblegum:light:muted)   echo "#666666" ;;
        bubblegum:light:dim)     echo "#999999" ;;
        bubblegum:light:strong)  echo "#000000" ;;
        bubblegum:light:error)   echo "#cc3333" ;;
        bubblegum:light:inactive) echo "#c8c8c8" ;;
        bubblegum:dark:critical_bg)  echo "#402020" ;;
        bubblegum:light:critical_bg) echo "#f3d4d4" ;;
        shhhed:dark:bg)          echo "#1a1a1e" ;;
        shhhed:dark:base)        echo "#1e1e22" ;;
        shhhed:dark:raised)      echo "#2a2a2f" ;;
        shhhed:dark:border)      echo "#38383d" ;;
        shhhed:dark:hover)       echo "#38383d" ;;
        shhhed:dark:fg)          echo "#cbcbcf" ;;
        shhhed:dark:muted)       echo "#85858b" ;;
        shhhed:dark:dim)         echo "#5c5c62" ;;
        shhhed:dark:strong)      echo "#dadadf" ;;
        shhhed:dark:error)       echo "#cc7078" ;;
        shhhed:dark:inactive)    echo "#2a2a2f" ;;
        shhhed:light:bg)         echo "#f1f6fb" ;;
        shhhed:light:base)       echo "#edf3f9" ;;
        shhhed:light:raised)     echo "#e1eaf3" ;;
        shhhed:light:border)     echo "#c6d2de" ;;
        shhhed:light:hover)      echo "#d7e1eb" ;;
        shhhed:light:fg)         echo "#1e1a14" ;;
        shhhed:light:muted)      echo "#656570" ;;
        shhhed:light:dim)        echo "#8a8a94" ;;
        shhhed:light:strong)     echo "#1e1a14" ;;
        shhhed:light:error)      echo "#b84e60" ;;
        shhhed:light:inactive)   echo "#c6d2de" ;;
        shhhed:dark:critical_bg)  echo "#3b2f32" ;;
        shhhed:light:critical_bg) echo "#f2e4e9" ;;
        *) return 1 ;;
    esac
}

# Names of the generated/installed themes for a family + variant + accent.
#   gtk_theme_name bubblegum dark pink  -> "Bubblegum"
#   gtk_theme_name shhhed light blue    -> "Shhhed Light Blue"
gtk_theme_name() {
    local base="${1^}"
    [ "$2" = light ] && base="$base Light"
    if [ "$3" = "$(theme_default_accent "$1")" ]; then echo "$base"; else echo "$base ${3^}"; fi
}

#   icon_theme_name bubblegum dark pink -> "Colloid-Bubblegum-Dark"
#   icon_theme_name shhhed dark blue    -> "Colloid-Shhhed-Blue-Dark"
icon_theme_name() {
    local mid="" var="Dark"
    [ "$3" != "$(theme_default_accent "$1")" ] && mid="-${3^}"
    [ "$2" = light ] && var="Light"
    echo "Colloid-${1^}${mid}-${var}"
}

# gtk_remap_pairs <family> <variant> <accent>
# Prints "from to" hex pairs that turn the source Bubblegum GTK theme (themes/)
# of that variant into <family>/<accent>. Used by make-theme-accents.sh.
gtk_remap_pairs() {
    local fam="$1" var="$2" acc="$3" role
    local roles="bg base raised border fg muted dim strong error"
    [ "$var" = light ] && roles="bg base raised border hover fg muted dim strong error"
    for role in $roles; do
        printf '%s %s\n' "$(theme_color bubblegum "$var" "$role")" "$(theme_color "$fam" "$var" "$role")"
    done
    printf '%s %s\n' "$(accent_color bubblegum "$var" pink)" "$(accent_color "$fam" "$var" "$acc")"
}

# --- saved selection ---------------------------------------------------------------

theme_current_family() {
    local f
    f=$(cat "$THEME_STATE_DIR/family" 2>/dev/null)
    case " $THEME_FAMILIES " in *" $f "*) echo "$f" ;; *) echo bubblegum ;; esac
}

# theme_current_accent <family>  -> the saved accent for that family (or its default)
theme_current_accent() {
    local fam="$1" a
    a=$(cat "$THEME_STATE_DIR/accent.$fam" 2>/dev/null)
    # Before per-family accents existed there was one shared "accent" file; it
    # only ever described Bubblegum, so it must not seed other families.
    if [ -z "$a" ] && [ "$fam" = bubblegum ]; then a=$(cat "$THEME_STATE_DIR/accent" 2>/dev/null); fi
    case " $(theme_accents "$fam") " in *" $a "*) echo "$a" ;; *) theme_default_accent "$fam" ;; esac
}

theme_current_variant() {
    case "$(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null)" in
        *Light*) echo light ;;
        *)       echo dark ;;
    esac
}
