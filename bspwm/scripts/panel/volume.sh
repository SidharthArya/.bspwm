#!/usr/bin/env bash
touch /tmp/bspwm_brightness_volume

VOLUME=$(pamixer --get-volume-human)

echo VOLUME:"V:$VOLUME" > /tmp/bspwm_panel
while read -r line;
do
    VOLUME=$(pamixer --get-volume-human)
    echo VOLUME:"V:^ca(1, /home/arya/.config/bspwm/scripts/panel/clicks/volume.sh) $VOLUME ^ca()" > /tmp/bspwm_panel

done < <(tail -f /tmp/bspwm_brightness_volume)
