#!/bin/sh


POINTS_LOW_BG="#600"

LEDGER_FILE=~/Documents/Org/Ledger/finance.ledger
while read -r line;
do
    ASSETS=$(ledger -f $LEDGER_FILE bal Assets | awk '{print $2}' | head -n 1)
    OUTPUT="^ca(1, emacsclient -n $LEDGER_FILE)A:"
    
    if [[ ${ASSETS%%.*} -lt 10000 ]];
    then
        OUTPUT+="^bg($POINTS_LOW_BG)^fg(#FFF)";
    else
        OUTPUT+="^bg()^fg()";
    fi
    OUTPUT+="$ASSETS"
    OUTPUT+="^fg()^bg()^ca()"
    echo ASSETS:"$OUTPUT" > /tmp/bspwm_panel
done < <(tail -n 5 -f $LEDGER_FILE)
