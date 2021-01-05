#!/bin/sh
COUNTER=0
for i in $(bspc query -M);
do
    COUNTER=$(( $COUNTER + 1 ))
    bash ~/.config/bspwm/scripts/panel/desktop.sh top $COUNTER &
    bash ~/.config/bspwm/scripts/panel/system.sh top $COUNTER &
    #xsh ~/.config/bspwm/scripts/panel/finance.sh bottom $COUNTER &
done

sleep 10
for i in $(xdo id -a dzentop);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done

