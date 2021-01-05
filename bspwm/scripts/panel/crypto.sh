#!/bin/sh
DOWN="#FF0000"
UP="#00FF00"
LASTCRYPTO=0
CRYPTOS="$(cat ~/Desktop/.crypto)"
while true;
do
    OUT="CRYPTO:"
    COUNTER=0
    for c in $CRYPTOS;
    do
        COUNTER=$(( $COUNTER + 1 ))
        PRICES="$(curl https://api.wazirx.com/api/v2/trades?market=$(echo $c | tr '[:upper:]' '[:lower:]')inr | jq .[].price | tr -d \")"
        CRYPTO=$(echo "$PRICES" | head -n 1)
        OUT+=" $c:"
        LASTCRYPTO=$(cat /tmp/bspwm_finance_panel_tmp | awk -F: -vCOUNTER=$(( 2+$COUNTER )) '{print $COUNTER}'| tr -d A-Za-z^\(\) | sed "s/\$DOWN//g" | sed "s/\$UP//g" )
        echo $CRYPTO $LASTCRYPTO
        
        if (( $(echo "$CRYPTO > $LASTCRYPTO" | bc -l ) ))
        then
            COLOR="^bg($UP) "
        elif (( $(echo "$CRYPTO < $LASTCRYPTO" | bc -l ) ))
        then
            COLOR="^bg($DOWN) "
        fi
        OUT+=$COLOR
        OUT+=$CRYPTO
        OUT+=" ^bg()"
    done
echo $OUT > /tmp/bspwm_panel
echo $OUT > /tmp/bspwm_finance_panel_tmp

sleep 1m
done
