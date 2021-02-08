#!/bin/sh


POINTS_LOW_BG="#600"

LEDGER_FILE=~/Documents/Org/Ledger/points.ledger
while read -r line;
do
    POINTS=$(ledger -f $LEDGER_FILE bal Assets | awk '{print $1}')
    OUTPUT="P:"
    if [[ $POINTS -lt 0 ]];
    then
        OUTPUT+="^bg($POINTS_LOW_BG)";
    else
        OUTPUT+="^bg()";
    fi
    OUTPUT+=$POINTS
    OUTPUT+="^bg()"
    echo POINTS:"$OUTPUT" > /tmp/bspwm_panel
done < <(tail -n 2 -f $LEDGER_FILE)
