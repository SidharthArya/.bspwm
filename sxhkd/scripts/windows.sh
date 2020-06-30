#!/usr/bin/env bash
wmctrl -l | awk '{$3="";print}' | dmenu -l 10 | awk '{print $1}' | xargs -I{} bspc node {} -g hidden=off -f
