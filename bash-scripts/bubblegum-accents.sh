# Bubblegum accent palette. Sourced by make-bubblegum-accents.sh,
# make-bubblegum-icons.sh, sway/toggle-theme.sh and sway/accent-picker.sh.
#
# Pink is the original Bubblegum accent and lives in the source themes
# (themes/Bubblegum, themes/Bubblegum Light). Other accents are generated
# copies of those themes with the accent colour swapped.

BUBBLEGUM_ACCENTS="pink blue green"

# accent_color <dark|light> <pink|blue|green>  ->  hex colour
accent_color() {
    case "$1:$2" in
        dark:pink)   echo "#d7afd7" ;;
        dark:blue)   echo "#87d7ff" ;;
        dark:green)  echo "#afd787" ;;
        light:pink)  echo "#b060a0" ;;
        light:blue)  echo "#0088cc" ;;
        light:green) echo "#357f55" ;;
        *) return 1 ;;
    esac
}

# Names of the generated/installed themes for a variant + accent.
# gtk_theme_name  dark pink -> "Bubblegum"   light blue -> "Bubblegum Light Blue"
gtk_theme_name() {
    local base="Bubblegum"
    [ "$1" = light ] && base="Bubblegum Light"
    if [ "$2" = pink ]; then echo "$base"; else echo "$base ${2^}"; fi
}

# icon_theme_name dark pink -> "Colloid-Bubblegum-Dark"   dark blue -> "Colloid-Bubblegum-Blue-Dark"
icon_theme_name() {
    local mid="" var="Dark"
    [ "$2" != pink ] && mid="-${2^}"
    [ "$1" = light ] && var="Light"
    echo "Colloid-Bubblegum${mid}-${var}"
}
