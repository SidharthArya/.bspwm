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
    if [ $CPU -gt 50 ];
    then
        CPU="^bg($CPU_HIGH_BG)^fg(#FF00FF) CPU:$CPU% "
    else
        CPU="^bg($CPU_OK_BG)^fg(#000000) CPU:$CPU% "
    fi
    MEM="$(echo $MEM*100/7820392 | bc)"
    if [ $MEM -gt 70 ];
    then
        MEM="^bg($CPU_HIGH_BG)^fg(#FF00FF) MEM:$MEM% "
    else
        MEM="^bg($CPU_OK_BG)^fg(#000000) MEM:$MEM% "
    fi
    CPU+="^bg()^fg()"
    MEM+="^bg()^fg()"
    echo CPU:$CPU > /tmp/bspwm_panel
    echo MEM:$MEM > /tmp/bspwm_panel
    sleep 10
done

