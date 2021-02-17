#!/bin/sh
BATTERY_LOW_BG="#600"
BATTERY_OK_BG="#060"
BATTERY_HIGH_BG="#060"
TEMP_HIGH_BG="#F00"

NOTIFY_SENT=false
while true
do
    thermal=$(acpi -t | awk '{print $4}')
    thermaltemp=${thermal%%.*}
    thermal=""
    if [ $thermaltemp -gt 60 ];
    then
        thermal+="^bg($TEMP_HIGH_BG)^fg(#FFF)"
        notify-send -u critical "Thermals" "Temparature High"
    elif [ $thermaltemp -gt 50 ];
    then
        thermal+="^bg($TEMP_HIGH_BG)^fg(#FFF)"
    fi
    thermal+="^ca(1, sh ~/.config/bspwm/scripts/panel/clicks/thermal.sh)"
    thermal+="T:$thermaltemp"
    thermal+="^ca()^fg()^bg()"
    BATTERYCAP=$(cat /sys/class/power_supply/BAT0/capacity)
    BATTERY=""
    if [ $BATTERYCAP -lt 11 ];
    then
        BATTERY+="^bg($BATTERY_LOW_BG)^fg(#FFF)"
        if ! $NOTIFY_SENT
           then 
            notify-send -u critical "Power Manager" "Battery Low"
	    mpv /usr/share/sounds/freedesktop/stereo/suspend-error.oga
            NOTIFY_SENT=true
        fi
    elif [ $BATTERYCAP -eq 79 ];
    then
        if ! $NOTIFY_SENT
           then 
            notify-send -u critical "Power Manager" "Battery Charged"
	    mpv /usr/share/sounds/freedesktop/stereo/dialog-error.oga
            NOTIFY_SENT=true
        fi
         BATTERY+="^bg($BATTERY_HIGH_BG)^fg(#FFF)"
    else
        NOTIFY_SENT=false
        BATTERY+="^bg(#FFFFFF)^fg()^ca()"
    fi
    BATTERY+="^ca(1, ~/.config/bspwm/scripts/panel/clicks/battery.sh)"
    BATTERY+="B:$BATTERYCAP%"
    BATTERY+="^ca()^bg()^fg()"
    echo BAT:$BATTERY > /tmp/bspwm_panel
    sleep 2
    echo THERMAL:$thermal > /tmp/bspwm_panel
    sleep 1m
done 
