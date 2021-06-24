#!/usr/bin/env bash

MONITORS=$(xrandr | grep " connected" | awk '{print $1}')
OTHERMONITORS=$(echo "$MONITORS" | tail -n +2)

[[ -z $OTHERMONITORS ]] && notify-send "No other monitor found" && exit 1
prev=$(echo "$MONITORS" | head -n 1)
for i in "$MONITORS";
do
    xrandr --output $i --right-of $prev --auto
    bspc monitor -d "D"
    notify-send "Connected" "$i"
    prev=$i
done
