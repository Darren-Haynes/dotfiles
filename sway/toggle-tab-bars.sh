#!/bin/bash

# Fetch the layout type of the immediate parent container of the focused window
PARENT_LAYOUT=$(swaymsg -t get_tree | jq -r '
  recurse(.nodes[], .floating_nodes[])
  | select(.nodes[].focused? == true or .floating_nodes[].focused? == true)
  | .layout
')

if [ "$PARENT_LAYOUT" = "tabbed" ]; then
    # 1. We are inside the tabs.
    # Split locally on the window first, then push it out to the right.
    # This leaves the remaining tabs completely untouched and in their original order.
    swaymsg "splith; move right"
else
    # 2. We are outside the tabs.
    # Push the window left to drop it back into the tabbed group.
    swaymsg "move left"
fi
