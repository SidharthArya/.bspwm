#!/bin/sh
COUNTER=0
MONITORS="$(bspc query -M)"
TYPE=$1

export fgcolor="#c2c2c7"
export fglightcolor="#929297"
export fgdarkcolor="#e2e2e7"
export height=24
export bgcolor="#111115"
export greencolor="#1EC337"
export redcolor="#f44336"
export bluecolor="#0A82FF"
export bluelightcolor="#409CFF"
export greenfgcolor=$bgcolor
export font="NotoSans:size=10:antialias=true"
export colRed500='#f44336'
export colYellow500='#ffeb3b'
export colBlue500='#2196f3'
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

trayer --edge top --widthtype request --height $height --iconspacing 4 --transparent on --alpha 0 --tint 0x${fgcolor:1} --padding 10 &

sleep 10
for i in $(xdo id -N trayer);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done

for i in $(xdo id -a dzentop);
         do
             xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $i
done



xdo move  -x 0 -y 24 $(xdo id -N Pcmanfm)

wait
