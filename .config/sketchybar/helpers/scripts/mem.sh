#!/bin/bash

NAME="widgets.mem1"
USAGE=$(~/.config/sway/scripts/mem_space.py | grep "Memory Used:" | awk '{printf "%.1f", $3} {print(substr($4, 1, 1))}')
sketchybar --set $NAME label="$USAGE"
