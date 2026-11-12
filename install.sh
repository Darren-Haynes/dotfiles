#!/usr/bin/env bash
# ==============================================================================
# Fedora 44 Sway (Wayland-only) bootstrap for ~/Dotfiles
#
#   git clone <your dotfiles repo> ~/Dotfiles && cd ~/Dotfiles && git checkout sway
#   ./install.sh              # everything
#   ./install.sh --dry-run    # print what would happen, change nothing
#   ./install.sh --links-only # only (re)create symlinks/config, no installs
#
# Idempotent: safe to re-run. Existing non-symlink files that would be replaced
# are moved aside as <name>.bak.<timestamp>, never deleted.
#
# NOTE: this file is public. It must contain no secrets, keys, tokens, emails or
# passphrases. Anything private (git identity, SSH key, private aliases) is
# handled outside this repo, see the "Private setup" notes printed at the end.
# ==============================================================================
set -euo pipefail

DOTFILES="$HOME/Dotfiles"
STAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
LINKS_ONLY=0

for arg in "$@"; do
    case "$arg" in
        --dry-run)    DRY_RUN=1 ;;
        --links-only) LINKS_ONLY=1 ;;
        -h|--help)    sed -n '2,13p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) echo "Unknown option: $arg (try --help)" >&2; exit 2 ;;
    esac
done

# --- helpers ------------------------------------------------------------------
log()  { printf '\n\033[1;35m==>\033[0m \033[1m%s\033[0m\n' "$*"; }
info() { printf '    %s\n' "$*"; }
short() { printf '%s' "~${1#"$HOME"}"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

run() {
    if (( DRY_RUN )); then
        printf '    [dry-run] %s\n' "$*"
    else
        "$@"
    fi
}

# link <target inside repo> <link path>
link() {
    local target="$1" dest="$2"
    if [ ! -e "$target" ]; then
        warn "not in repo, skipping: ${target#"$HOME"/}"
        return 0
    fi
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$target" ]; then
        info "ok      $(short "$dest")"
        return 0
    fi
    run mkdir -p "$(dirname "$dest")"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        info "backup  $(short "$dest") -> $(basename "$dest").bak.$STAMP"
        run mv "$dest" "$dest.bak.$STAMP"
    fi
    run ln -s "$target" "$dest"
    info "linked  $(short "$dest")"
}

# --- preflight ----------------------------------------------------------------
preflight() {
    (( EUID != 0 )) || die "Run as your normal user, not root (sudo is used where needed)."

    # Several configs/scripts reference ~/Dotfiles directly.
    local here
    here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
    [ "$here" = "$(cd "$DOTFILES" 2>/dev/null && pwd -P)" ] \
        || die "This repo must live at ~/Dotfiles (found it at $here)."

    if (( ! LINKS_ONLY )); then
        [ -r /etc/fedora-release ] || die "This script targets Fedora."
        command -v dnf >/dev/null || die "dnf not found."
        info "$(cat /etc/fedora-release)"
        (( DRY_RUN )) || sudo -v
    fi
}

# --- repositories ---------------------------------------------------------------
setup_repos() {
    log "Enabling repositories"
    local fedora_ver; fedora_ver="$(rpm -E %fedora)"

    run sudo dnf install -y dnf5-plugins

    # RPM Fusion (free): full ffmpeg/x264 so wf-recorder's libx264 works
    if ! rpm -q rpmfusion-free-release >/dev/null 2>&1; then
        run sudo dnf install -y \
            "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${fedora_ver}.noarch.rpm"
    fi

    # COPRs (third party, not in the main Fedora repos)
    #   swayfx  : sway fork with blur/rounded corners (replaces stock sway)
    #   yazi    : yazi + resvg
    #   zellij  : terminal multiplexer
    #   hyprland: hyprpicker (colour picker, bound to $mod+Shift+x)
    local copr
    for copr in swayfx/swayfx lihaohong/yazi varlad/zellij nett00n/hyprland; do
        run sudo dnf copr enable -y "$copr"
    done

    # Brave
    if [ ! -f /etc/yum.repos.d/brave-browser.repo ]; then
        run sudo dnf config-manager addrepo \
            --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    fi
}

# --- packages (all Wayland-native or CLI; nothing here needs an X server) -------
install_packages() {
    log "Installing packages"

    # swayfx conflicts with / replaces stock sway (and provides "sway", so the
    # Fedora sway-config package stays happy).
    run sudo dnf install -y --allowerasing swayfx

    # Full ffmpeg from RPM Fusion (needs libx264 for wf-recorder)
    if rpm -q ffmpeg-free >/dev/null 2>&1; then
        run sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    else
        run sudo dnf install -y ffmpeg
    fi

    local pkgs=(
        # Shell & CLI
        zsh git git-delta curl lsd fzf vim-enhanced neovim jq btop yazi zellij
        ImageMagick mpv gocryptfs python3-ipython xdg-utils flatpak
        # Sway session pieces (most ship with the Sway spin; dnf skips what's there)
        waybar foot rofi dunst swaybg swayidle swaylock
        grim slurp grimshot swappy wl-clipboard cliphist
        wf-recorder wayvnc hyprpicker tesseract tesseract-langpack-eng
        libnotify pavucontrol NetworkManager-tui blueman
        xdg-desktop-portal-wlr xdg-desktop-portal-gtk gtk-update-icon-cache
        # GUI apps
        Thunar speedcrunch qt6-qtwayland
        brave-browser
        # Fonts (Fira Code, Font Awesome icons for waybar, emoji)
        fira-code-fonts fontawesome-6-free-fonts fontawesome-6-brands-fonts
        google-noto-color-emoji-fonts
    )
    run sudo dnf install -y --skip-unavailable "${pkgs[@]}"

    # The Sway spin ships mako; this setup uses dunst. Two notification daemons
    # fight over org.freedesktop.Notifications.
    if rpm -q mako >/dev/null 2>&1; then
        info "removing mako (replaced by dunst)"
        run sudo dnf remove -y mako
    fi
}

install_extras() {
    log "Flatpak apps (Bitwarden)"
    run sudo flatpak remote-add --if-not-exists --system flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
    run sudo flatpak install -y --system flathub com.bitwarden.desktop

    log "Zed editor"
    if [ -x "$HOME/.local/bin/zed" ]; then
        info "already installed"
    elif (( DRY_RUN )); then
        info "[dry-run] curl -f https://zed.dev/install.sh | sh"
    else
        curl -fsSL https://zed.dev/install.sh | sh
    fi

    log "Pure prompt (zsh)"
    local pure="$HOME/.local/share/zsh/pure"
    if [ -d "$pure/.git" ]; then
        run git -C "$pure" pull --ff-only -q
    else
        run mkdir -p "$(dirname "$pure")"
        run git clone --depth 1 https://github.com/sindresorhus/pure.git "$pure"
    fi

    log "Colloid icon theme -> Bubblegum folder colours"
    if [ ! -d "$HOME/.local/share/icons/Colloid-Pink-Dark" ]; then
        if (( DRY_RUN )); then
            info "[dry-run] clone Colloid-icon-theme and run ./install.sh -t pink"
        else
            local tmp; tmp="$(mktemp -d)"
            git clone --depth 1 https://github.com/vinceliuice/Colloid-icon-theme "$tmp/colloid"
            (cd "$tmp/colloid" && ./install.sh -t pink)
            rm -rf "$tmp"
        fi
    else
        info "Colloid-Pink already present"
    fi
    if (( DRY_RUN )); then
        info "[dry-run] $DOTFILES/bash-scripts/make-bubblegum-icons.sh pink"
        info "[dry-run] $DOTFILES/bash-scripts/make-bubblegum-accents.sh  (blue/green GTK + icon themes)"
    else
        "$DOTFILES/bash-scripts/make-bubblegum-icons.sh" pink
        "$DOTFILES/bash-scripts/make-bubblegum-accents.sh"
    fi
}

# --- symlinks & config -------------------------------------------------------------
setup_links() {
    log "Creating directories"
    run mkdir -p "$HOME/.config" "$HOME/.local/bin" \
        "$HOME/Pictures/Wallpaper" "$HOME/Pictures/Screenshots" "$HOME/Videos"

    # Bundled wallpapers are copied (never overwritten) so you can add your own.
    local w
    for w in "$DOTFILES"/wallpapers/*; do
        [ -f "$w" ] || continue
        if [ ! -e "$HOME/Pictures/Wallpaper/$(basename "$w")" ]; then
            info "copying wallpaper $(basename "$w")"
            run cp "$w" "$HOME/Pictures/Wallpaper/"
        fi
    done

    log "Linking config into ~/.config"
    local d
    for d in sway waybar foot rofi btop yazi swappy nvim; do
        link "$DOTFILES/$d" "$HOME/.config/$d"
    done
    link "$DOTFILES/zellij/config.kdl"   "$HOME/.config/zellij/config.kdl"
    link "$DOTFILES/zed/settings.json"   "$HOME/.config/zed/settings.json"
    link "$DOTFILES/zed/keymap.json"     "$HOME/.config/zed/keymap.json"
    link "$DOTFILES/zed/themes/bubblegum/bubblegum+.json" \
         "$HOME/.config/zed/themes/bubblegum+.json"

    # dunst: layout is tracked; the active palette is a symlink that
    # sway/toggle-theme.sh flips between dark and light.
    link "$DOTFILES/dunst/dunstrc"          "$HOME/.config/dunst/dunstrc"
    link "$DOTFILES/dunst/colors-dark.conf" "$HOME/.config/dunst/dunstrc.d/10-colors.conf"

    # foot.ini includes this file (foot won't start without it); the theme
    # toggle rewrites it. Seed with dark only if it doesn't exist yet.
    run mkdir -p "$HOME/.local/state/foot"
    if [ ! -e "$HOME/.local/state/foot/theme.ini" ]; then
        info "seeding foot theme state (dark)"
        if (( ! DRY_RUN )); then
            printf '[main]\ninitial-color-theme=dark\n' > "$HOME/.local/state/foot/theme.ini"
        fi
    fi

    log "Linking themes, shell and tool configs"
    link "$DOTFILES/themes"                       "$HOME/.themes"
    link "$DOTFILES/zsh/zshrc"                    "$HOME/.zshrc"
    link "$DOTFILES/vim/vimrc"                    "$HOME/.vimrc"
    link "$DOTFILES/vim/colors"                   "$HOME/.vim/colors"
    link "$DOTFILES/ipython/profile_darren"       "$HOME/.ipython/profile_darren"
    link "$DOTFILES/SpeedCrunch/color-schemes"    "$HOME/.local/share/SpeedCrunch/color-schemes"

    # SpeedCrunch rewrites its ini constantly (window geometry etc.), so copy the
    # tracked one as a starting point instead of symlinking it.
    local sc="$HOME/.config/SpeedCrunch/SpeedCrunch.ini"
    if [ ! -e "$sc" ]; then
        info "seeding SpeedCrunch.ini from the repo (Bubblegum dark)"
        run mkdir -p "$(dirname "$sc")"
        run cp "$DOTFILES/SpeedCrunch/SpeedCrunch.ini" "$sc"
    fi

    log "Linking helper scripts into ~/.local/bin"
    local f
    for f in "$DOTFILES"/bash-scripts/*; do
        if [ -f "$f" ]; then
            link "$f" "$HOME/.local/bin/$(basename "$f")"
        fi
    done
}

configure_system() {
    log "System configuration"

    # Default shell -> zsh
    if command -v zsh >/dev/null 2>&1; then
        local current; current="$(getent passwd "$USER" | cut -d: -f7)"
        if [ "$current" != "$(command -v zsh)" ]; then
            info "setting login shell to zsh"
            run sudo usermod -s "$(command -v zsh)" "$USER"
        fi
    fi

    # Brave as default browser
    if command -v xdg-settings >/dev/null 2>&1 && [ -f /usr/share/applications/brave-browser.desktop ]; then
        run xdg-settings set default-web-browser brave-browser.desktop || warn "could not set default browser"
    fi

    # Bubblegum GTK/icon defaults (dark). Needs a running user session (dconf).
    if [ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ] && command -v gsettings >/dev/null 2>&1; then
        run gsettings set org.gnome.desktop.interface gtk-theme    'Bubblegum'
        run gsettings set org.gnome.desktop.interface icon-theme   'Colloid-Bubblegum-Dark'
        run gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    else
        warn "No user D-Bus session; after logging into sway, run:"
        info "gsettings set org.gnome.desktop.interface gtk-theme 'Bubblegum'"
        info "gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Bubblegum-Dark'"
        info "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
    fi

    # Private dotfiles repo (aliases etc.). The URL is NOT stored here: pass it
    # via the environment, e.g.  PRIVATE_DOTFILES_REPO=git@github.com:you/repo.git ./install.sh
    local priv="$HOME/.config/private-dotfiles"
    if [ -d "$priv" ]; then
        info "private dotfiles already present"
    elif [ -n "${PRIVATE_DOTFILES_REPO:-}" ]; then
        run git clone "$PRIVATE_DOTFILES_REPO" "$priv" \
            || warn "could not clone private dotfiles (is your SSH key added to GitHub?)"
    else
        info "PRIVATE_DOTFILES_REPO not set; skipping private dotfiles"
    fi
}

post_notes() {
    cat <<'EOF'

==> Done. Remaining manual steps
    1. Log out and back in (sway was replaced by swayfx; zsh is now your login shell).
    2. Private setup (never stored in this repo):
         - git identity:   git config --global user.name  "..."
                           git config --global user.email "..."
         - SSH key:        ssh-keygen -t ed25519, add the .pub to GitHub
         - private repo:   PRIVATE_DOTFILES_REPO=<ssh url> ./install.sh --links-only
    3. Brave: load the Bubblegum theme from ~/Dotfiles/brave/brave-theme-bubblegum
         (brave://extensions -> Developer mode -> Load unpacked).
    4. Wallpaper: green-tree-mist.jpg is copied to ~/Pictures/Wallpaper; add more
         there and pick with Mod+Shift+w.
    5. Remote desktop: wayvnc listens on 127.0.0.1:5900. To reach it over an SSH
         tunnel, enable sshd yourself:  sudo systemctl enable --now sshd
EOF
}

# --- main -----------------------------------------------------------------------------
preflight
if (( ! LINKS_ONLY )); then
    setup_repos
    install_packages
    install_extras
fi
setup_links
configure_system
post_notes
