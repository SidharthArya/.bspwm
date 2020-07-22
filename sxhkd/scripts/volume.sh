#!/bin/sh
VOLUME="$(pamixer --get-volume)"
echo $VOLUME
case "$1" in
    "increase")
        if  [ $VOLUME -lt 100 ];
        then
            pactl -- set-sink-volume 0 +5%;
        fi
        ;;
    "decrease")
        if [ $VOLUME -gt 0 ];
        then
            pactl -- set-sink-volume 0 -5%;
        fi
        ;;
esac

