#!/bin/sh

while true;
do
    DATE=$(date +"%a %d %b %Y %H:%M")
    echo DATE:"^bg(#555555)^fg(#FFFFFF) $DATE ^bg()^fg() " > /tmp/bspwm_panel
    sleep 5
done 

