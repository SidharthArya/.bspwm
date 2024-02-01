#!/bin/sh
EXEC="$(rofi -show drun -font 'Source Code Pro 12' -theme dmenu)"
sleep 1 && echo "$EXEC" | ${SHELL:-"/bin/sh"}
