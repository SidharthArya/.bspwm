#!/bin/sh
bspc config bottom_padding 0 && pgrep -f finance | tail -n +3 | xargs kill || {
COUNTER=0
for i in $(bspc query -M);
do
    COUNTER=$(( $COUNTER + 1 ))
    sh ~/.config/bspwm/scripts/panel/finance.sh bottom $COUNTER &
done

sleep 10
for i in $(xdo id -a dzentop);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done

}
wait
pkill -f finance_panel
