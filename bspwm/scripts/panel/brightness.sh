#!/usr/bin/env bash
touch /tmp/bspwm_brightness_volume

VOLUME=$(pamixer --get-volume-human)
BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)

echo VOLUME:"V:$VOLUME" > /tmp/bspwm_panel
echo BRIGHTNESS:"Br:$BRIGHTNESS" > /tmp/bspwm_panel
while read -r line;
do
    VOLUME=$(pamixer --get-volume-human)
    BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)
    BRIGHTNESS="$(echo $BRIGHTNESS/19200 | bc)"
    echo VOLUME:"V:^ca(1, /home/arya/.config/bspwm/scripts/panel/clicks/volume.sh) $VOLUME ^ca()" > /tmp/bspwm_panel
    echo BRIGHTNESS:"^ca(1, /home/arya/.config/bspwm/scripts/panel/clicks/brightness.sh) Br:$BRIGHTNESS ^ca()" > /tmp/bspwm_panel

done < <(tail -f "/tmp/bspwm_brightness_volume")
