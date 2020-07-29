#!/bin/sh

case "$1" in
    concentration)
        notify-send Timer "Starting Concentration" && sleep 50m && notify-send Timer "Break Time" && sleep 10m && notify-send Timer "Break Time Over" && echo 1 >> ~/Documents/Org/Tracking/.concentration;
        ;;
esac
