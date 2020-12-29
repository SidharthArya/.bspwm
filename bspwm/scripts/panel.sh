#!/bin/sh
sh ~/.config/bspwm/scripts/panel/desktop.sh &
sh ~/.config/bspwm/scripts/panel/system.sh &
sleep 10
for i in $(xdo id -a dzentop);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done

