#!/bin/sh
COUNTER=0
MONITORS="$(bspc query -M)"
TYPE=$1
case "$TYPE" in
    bothonly)
        MONITORS=$(echo "$MONITORS" | head -n 1)
        ;;
    systemonly)
        SYSTEMONLY=1
        ;;
    *)
        SYSTEMONLY=1
esac
for i in $MONITORS;
do
    COUNTER=$(( $COUNTER + 1 ))
    bash ~/.config/bspwm/scripts/panel/desktop.sh top $COUNTER &
    if [[ $SCREENONLY -eq 1 ]];
    then
        pgrep system.sh || bash ~/.config/bspwm/scripts/panel/system.sh top 1 &
    else
        pgrep system.sh || bash ~/.config/bspwm/scripts/panel/system.sh top $COUNTER &
    fi
    #sh ~/.config/bspwm/scripts/panel/finance.sh bottom $COUNTER &
done

sleep 10
for i in $(xdo id -a dzentop);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done

wait
