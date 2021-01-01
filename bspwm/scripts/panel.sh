#!/bin/sh
COUNTER=0
for i in $(bspc query -M);
do
    COUNTER=$(( $COUNTER + 1 ))
    sh ~/.config/bspwm/scripts/panel/desktop.sh $COUNTER &
    sh ~/.config/bspwm/scripts/panel/system.sh $COUNTER &
done

sleep 10
for i in $(xdo id -a dzentop);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done

