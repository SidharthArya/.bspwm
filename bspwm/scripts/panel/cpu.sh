#!/usr/bin/env bash

CPU_OK_BG="#060"
CPU_HIGH_BG="#600"

# while true;
# do

#     ALL="$(ps -eo %cpu | tail -n +2)"
#     COUNT=$(echo "$ALL" )

#     CPU=$(echo "$ALL" | paste -sd '+'|bc)
#     MEM=$(free -k | head -n -1 | tail -n 1 | awk '{print $3}' )
#     #echo $(( $CPU/$COUNT )) $(( $MEM/$COUNT ))
#     CPU=$(echo $CPU/8 | bc)
#     COUTPUT=""
#     MOUTPUT=""
#     if [ $CPU -gt 50 ];
#     then
#         COUTPUT="^bg($CPU_HIGH_BG)^fg(#FFF)"
#     else
#         COUTPUT="^bg()^fg()"
#     fi
#     MEM="$(echo $MEM*100/7820392 | bc)"
#     if [ $MEM -gt 70 ];
#     then
#         MOUTPUT="^bg($CPU_HIGH_BG)^fg(#FFF)"
#     else
#         MOUTPUT="^bg()^fg()"
#     fi
#     COUTPUT+="^ca(3, ~/.config/bspwm/scripts/panel/clicks/cpu.sh)^ca(1, ~/.config/bspwm/scripts/panel/clicks/cpu-1.sh)C:^ca()$CPU%^ca()"
#     COUTPUT+="^bg()^fg()"
#     MOUTPUT+="^ca(1, ~/.config/bspwm/scripts/panel/clicks/mem.sh)M:$MEM%^ca()"
#     MOUTPUT+="^bg()^fg()"
#     echo CPU:$COUTPUT > /tmp/bspwm_panel
#     echo MEM:$MOUTPUT > /tmp/bspwm_panel
#     sleep 10
# done

gcpubar -i 6 -h 3 -w 30 -bg "#141" -fg "#3F0" | while read -r line;
do
    echo CPU:C: $line > /tmp/bspwm_panel
done
