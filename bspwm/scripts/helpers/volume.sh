#!/bin/sh
VOLUME="$(wpctl get-volume @DEFAULT_SINK@)"

echo $VOLUME
case "$1" in
    "increase")
        if  [ $VOLUME -lt 1.2 ];
        then
					wpctl set-volume @DEFAULT_SINK@ +2%
            # pactl -- set-sink-volume 0 +2% && canberra-gtk-play -i audio-volume-change;
        fi
        ;;
    "decrease")
        if [ $VOLUME -gt 0 ];
        then
					wpctl set-volume @DEFAULT_SINK@ -2%
            # pactl -- set-sink-volume 0 -2% && canberra-gtk-play -i audio-volume-change;
        fi
        ;;
esac

echo 1 > /tmp/bspwm_brightness_volume
