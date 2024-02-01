#!/bin/sh
export IFS=$'\n'

case "$1" in
    "current")
        ID="$(xdo id)"
        bspc node -g hidden=on -f
        echo -e "$ID" >> /tmp/bspwm_minimize_stack
        ;;
esac
