#!/bin/sh
DOWN="#FF0000"
UP="#00FF00"
LASTCRYPTO=0
STOCKS="$(cat ~/Desktop/.stocks)"
while true;
do
    OUT="NSE:"
    COUNTER=0
    for c in $STOCKS;
    do
        COUNTER=$(( $COUNTER + 1 ))
        PRICES="$(python ~/.config/bspwm/scripts/panel/assets/python/nse_getprice.py $c)"
        CRYPTO=$(echo "$PRICES" | head -n 1)
        OUT+=" ^ca(1, st -e sh ~/.config/bspwm/scripts/panel/assets/shell/nse_stock_news.sh $c)$c:"
        LASTCRYPTO=$(cat /tmp/bspwm_finance_panel_nse | awk -F: -vCOUNTER=$(( 2+$COUNTER )) '{print $COUNTER}'| tr -d A-Za-z^\(\) | sed 's/$UP//g' | sed 's/$DOWN//g')
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
        OUT+=" ^bg()^ca()"
    done
echo $OUT > /tmp/bspwm_finance_panel
echo $OUT > /tmp/bspwm_finance_panel_nse
if (( $(date +"%H%M") > 1530 ));
then
    break
fi
sleep 1m
done
