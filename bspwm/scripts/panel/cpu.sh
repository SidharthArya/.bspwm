#!/bin/sh

CPU_OK_BG="#00FF00"
CPU_HIGH_BG="#FF0000"

while true;
do

    ALL="$(ps -eo %cpu | tail -n +2)"
    COUNT=$(echo "$ALL" )

    CPU=$(echo "$ALL" | paste -sd '+'|bc)
    MEM=$(free -k | head -n -1 | tail -n 1 | awk '{print $3}' )
    #echo $(( $CPU/$COUNT )) $(( $MEM/$COUNT ))
    CPU=$(echo $CPU/8 | bc)
    COUTPUT=""
    MOUTPUT=""
    if [ $CPU -gt 50 ];
    then
        COUTPUT="^bg($CPU_HIGH_BG)^fg(#FF00FF)"
    else
        COUTPUT="^bg($CPU_OK_BG)^fg(#000000)"
    fi
    MEM="$(echo $MEM*100/7820392 | bc)"
    if [ $MEM -gt 70 ];
    then
        MOUTPUT="^bg($CPU_HIGH_BG)^fg(#FF00FF)"
    else
        MOUTPUT="^bg($CPU_OK_BG)^fg(#000000)"
    fi
    COUTPUT+="^ca(1, ~/.config/bspwm/scripts/panel/cpu_click.sh) C:$CPU% ^ca()"
    COUTPUT+="^bg()^fg()"
    MOUTPUT+="^ca(1, ~/.config/bspwm/scripts/panel/mem_clock.sh) M:$MEM% ^ca()"
    MOUTPUT+="^bg()^fg()"
    echo CPU:$COUTPUT > /tmp/bspwm_panel
    echo MEM:$MOUTPUT > /tmp/bspwm_panel
    sleep 10
done

