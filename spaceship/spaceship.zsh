# -------------------------------------------------------------
# Spaceship Prompt - Dram Theme Color Sync
# -------------------------------------------------------------

# Define the precise Dram hex colors as reusable variables
DRAM_BG="#0f3b3a"       # Deep dark teal
DRAM_SURFACE="#155352"  # Tab-bar medium teal
DRAM_FG="#b1c9c3"       # Mint white / Seafoam
DRAM_ACCENT="#00c420"   # Zoom bright green
DRAM_WARN="#e99f10"     # Amber yellow
DRAM_RED="#d74200"      # Error red

SPACESHIP_PROMPT_ORDER=(
  os              # OS icon (first)
  time            # Time
  user            # Username
  host            # Hostname
  dir             # Directory
  git             # Git
  node            # Node.js
  python          # Python
  golang          # Go
  rust            # Rust
  line_sep        # Line break
  char            # Prompt character
)

spaceship remove package  # Keeps your existing package exclusion

# 2. Main Character / Success Arrow Customization
spaceship_character_symbol="➜"
spaceship_character_color_success="$DRAM_ACCENT"
spaceship_character_color_failure="$DRAM_RED"

# 3. Time Section
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=""
SPACESHIP_TIME_PREFIX_COLOR="$DRAM_SURFACE"
SPACESHIP_TIME_COLOR="$DRAM_FG"
SPACESHIP_TIME_FORMAT='%D{%H:%M}'   # 24h HH:MM; use '%D{%r}' for 12h am/pm

# 4. Directory (Path) Styling
spaceship_dir_color="$DRAM_FG"
spaceship_dir_prefix="in "
spaceship_dir_prefix_color="$DRAM_SURFACE"

# 5. Git Integration Styling
spaceship_git_branch_color="$DRAM_FG"
spaceship_git_branch_prefix="on "
spaceship_git_branch_prefix_color="$DRAM_SURFACE"

# Git Status Flags
spaceship_git_status_color="$DRAM_WARN"
spaceship_git_status_dirty="*"
spaceship_git_status_untracked="?"

# 6. Language Runtimes Styling
spaceship_node_color="$DRAM_FG"
spaceship_rust_color="$DRAM_FG"
spaceship_golang_color="$DRAM_FG"
spaceship_python_color="$DRAM_FG"

# 7. Custom OS Section (icon only, no text)
# 256-color: 152 ≈ DRAM_FG, 30 ≈ DRAM_SURFACE

SPACESHIP_OS_SHOW=true
SPACESHIP_OS_PREFIX=""
SPACESHIP_OS_SUFFIX=" "
SPACESHIP_OS_COLOR="152"

spaceship_os() {
  [[ $SPACESHIP_OS_SHOW == false ]] && return

  local icon=""
  case "$(uname -s)" in
    Darwin)
      icon="🍎"
      ;;
    Linux)
      # Detect Fedora Workstation specifically
      if [[ -f /etc/os-release ]]; then
        local id variant
        id=$(grep -oP '^ID=\K.*' /etc/os-release | tr -d '"')
        variant=$(grep -oP '^VARIANT_ID=\K.*' /etc/os-release | tr -d '"')
        if [[ "$id" == "fedora" && "$variant" == "workstation" ]]; then
          icon="🌀"   # GNOME icon — swap to whatever you prefer
        else
          icon="🐧"
        fi
      else
        icon="🐧"
      fi
      ;;
    *)
      icon="💻"
      ;;
  esac

  spaceship::section::v4 \
    --color "$SPACESHIP_OS_COLOR" \
    --prefix "$SPACESHIP_OS_PREFIX" \
    --suffix "$SPACESHIP_OS_SUFFIX" \
    "$icon"
}
