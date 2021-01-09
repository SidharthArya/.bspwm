#!/bin/sh
BATTERY_LOW_BG="#600"
BATTERY_OK_BG="#060"
BATTERY_HIGH_BG="#060"

NOTIFY_SENT=false
while true
do
    thermal=$(acpi -t | awk '{print $4}')
    thermal=${thermal%%.*}
    if [ $thermal -gt 45 ];
    then
       thermal="^bg($BATTERY_HIGH_BG)^fg(#FFF) T:$thermal ^fg()^bg()"
    else
       thermal=" T:$thermal "
    fi
    line=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ $line -lt 11 ];
    then
        line=$(echo "^bg($BATTERY_LOW_BG)^fg(#FFF) B:$line% ")
        if ! $NOTIFY_SENT
           then 
            notify-send -u critical "Power Manager" "Battery Low"
            NOTIFY_SENT=true
        fi
    elif [ $line -eq 79 ];
    then
        if ! $NOTIFY_SENT
           then 
            notify-send -u critical "Power Manager" "Battery Charged"
            NOTIFY_SENT=true
        fi
         line=$(echo "^bg($BATTERY_HIGH_BG)^fg(#FFF) B:$line% ")
    else
        NOTIFY_SENT=false
        line=$(echo "^bg(#FFFFFF)^fg() B:$line% ")
    fi
    line+="^bg()^fg()"
    echo BAT:$line > /tmp/bspwm_panel
    sleep 2
    echo THERMAL:$thermal > /tmp/bspwm_panel
    sleep 1m
done 
