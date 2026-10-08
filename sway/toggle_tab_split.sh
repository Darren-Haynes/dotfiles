#!/bin/bash
# Toggle tabbed layout vs split layout in Sway / SwayFX
swaymsg "layout toggle tabbed split" >/dev/null 2>&1
