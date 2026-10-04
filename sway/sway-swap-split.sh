#!/bin/bash

# 1. Grab the IDs of all windows sharing the same parent container as the focused window
WINDOW_IDS=$(swaymsg -t get_tree | jq -r '
  recurse(.nodes[], .floating_nodes[])

  | select(.nodes[]? | .focused == true)
  | .nodes[].id
')

# Convert the space-separated string of IDs into a clean Bash array
ID_ARRAY=($WINDOW_IDS)

# 2. Strict Boundary Safety Check:
# If there are not exactly 2 windows in this split container, do absolutely nothing.
if [ ${#ID_ARRAY[@]} -ne 2 ]; then
    exit 0
fi

# 3. Swap the two containers cleanly using their raw Sway container IDs
swaymsg "[con_id=${ID_ARRAY[0]}] swap container with con_id ${ID_ARRAY[1]}"
