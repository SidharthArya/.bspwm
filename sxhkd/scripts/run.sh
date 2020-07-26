#!/bin/sh
EXEC="$(dmenu_path | rofi -dmenu)"
sleep 1 && echo "$EXEC" | ${SHELL:-"/bin/sh"}
