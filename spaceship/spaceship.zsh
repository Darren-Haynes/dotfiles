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

# 1. Prompt Order & Component Management
spaceship remove package  # Keeps your existing package exclusion

# 2. Main Character / Success Arrow Customization
spaceship_character_symbol="➜"
spaceship_character_color_success="$DRAM_ACCENT"
spaceship_character_color_failure="$DRAM_RED"

# 3. Directory (Path) Styling
spaceship_dir_color="$DRAM_FG"
spaceship_dir_prefix="in "
spaceship_dir_prefix_color="$DRAM_SURFACE"

# 4. Git Integration Styling
spaceship_git_branch_color="$DRAM_FG"
spaceship_git_branch_prefix="on "
spaceship_git_branch_prefix_color="$DRAM_SURFACE"

# Git Status Flags (Clean alignment with your workspace warnings)
spaceship_git_status_color="$DRAM_WARN"
spaceship_git_status_dirty="*"
spaceship_git_status_untracked="?"

# 5. Language Runtimes Styling
spaceship_node_color="$DRAM_FG"
spaceship_rust_color="$DRAM_FG"
spaceship_golang_color="$DRAM_FG"
spaceship_python_color="$DRAM_FG"

# Directory Truncation Configuration (Keeps split screens clean)
SPACESHIP_DIR_TRUNC=2           # Only show the last 2 directory segments
SPACESHIP_DIR_TRUNC_REPO=true   # Lock truncation strictly to the Git repository root directory
