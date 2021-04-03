#!/bin/sh

POINTS_LOW_BG="#600"

LEDGER_FILE=~/Documents/Org/Ledger/points.ledger
while read -r line;
do
    POINTS=$(ledger -f $LEDGER_FILE bal Assets | awk '{print $1}')
    OUTPUT=""
    if [[ $POINTS -lt 0 ]];
    then
        OUTPUT+="^bg($POINTS_LOW_BG)^fg(#FFF)";
    else
        OUTPUT+="^bg()^fg()";
    fi
    if [ -z $POINTS ] ;
    then
        POINTS=0
    fi
    OUTPUT+="^ca(1, emacsclient -n $LEDGER_FILE)P:"
    OUTPUT+="$POINTS"
    OUTPUT+="^ca()^fg()^bg()"
    echo POINTS:"$OUTPUT" > /tmp/bspwm_panel
done < <(tail -n 5 -f $LEDGER_FILE)
