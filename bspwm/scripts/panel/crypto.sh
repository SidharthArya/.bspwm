#!/bin/sh
DOWN="#600"
UP="#060"
LASTCRYPTO=0
CRYPTOS="$(cat ~/Desktop/.crypto)"
while true;
do
    OUT="CRYPTO:"
    COUNTER=0
    for c in $CRYPTOS;
    do
        COUNTER=$(( $COUNTER + 1 ))
        MARKET="$(echo $c | tr '[:upper:]' '[:lower:]')inr"
        PRICES="$(curl https://api.wazirx.com/api/v2/trades?market=$MARKET| jq .[].price | tr -d \")"
        CRYPTO=$(echo "$PRICES" | head -n 1)
        OUT+="^ca(1,sh ~/.config/bspwm/scripts/panel/clicks/cryptonews.sh $c) $c^ca():^ca(1, sh ~/.config/bspwm/scripts/panel/clicks/cryptodepth.sh $MARKET)"
        LASTCRYPTO=$(cat /tmp/bspwm_finance_panel_tmp | awk -F: -vCOUNTER=$(( 2+$COUNTER )) '{print $COUNTER}'| tr -d A-Za-z^\(\) | sed "s/\$DOWN//g" | sed "s/\$UP//g" )
        echo $CRYPTO $LASTCRYPTO
        
        if (( $(echo "$CRYPTO > $LASTCRYPTO" | bc -l ) ))
        then
            COLOR="^bg($UP)^fg(#FFF) "
        elif (( $(echo "$CRYPTO < $LASTCRYPTO" | bc -l ) ))
        then
            COLOR="^bg($DOWN)^fg(#FFF) "
        fi
        OUT+=$COLOR
        OUT+=$CRYPTO
        OUT+=" ^bg()^fg()^ca()"
    done
echo $OUT > /tmp/bspwm_panel
echo $OUT > /tmp/bspwm_finance_panel_tmp

sleep 1m
done
