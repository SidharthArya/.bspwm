#!/bin/sh

while true;
do
    DATE=$(date +"%H:%M")
    echo DATE:"^bg($fgcolor)^fg($bgcolor) ^ca(1, ~/.config/bspwm/scripts/panel/date_click.sh)$DATE ^ca()^bg()^fg() " > /tmp/bspwm_panel
    sleep 10
done 

