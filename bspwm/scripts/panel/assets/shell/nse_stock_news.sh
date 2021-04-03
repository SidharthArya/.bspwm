#!/bin/sh
STOCK=$(echo $1 | tr '[:lower:]' '[:upper:]')
CONTENT=$(curl -i -H "user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" -H "referer: https://www.tradingview.com/"  -H "origin: https://www.tradingview.com" "https://news-headlines.tradingview.com/headlines/?category=stock&client=web&country=US&lang=en&locale=en&proSymbol=NSE%3A$STOCK" | tail -n +15| jq '.[] | "TITLE: \(.title) \nDESCRIPTION:\(.shortDescription)\nPUBLISHED:\(.published)\nEOF"')
export TMP=$IFS
export IFS=$'" "'
for i in "$CONTENT";
do
    COUNTER=0
    TITLE=""
    DESCRIPTION=""
    DATE=""
    NET=$(echo -e \"$i\" | tr -d \" )
    export IFS=$'\n'
    for i in $NET;
    do
        COUNTER=$(( $COUNTER + 1 ))
        case $i in
            \ TITLE:*)
                TITLE=${i##\ TITLE:}
                ;;
            DESCRIPTION:*)
                DESCRIPTION=${i##DESCRIPTION:}
                ;;
            PUBLISHED:*)
                PUBLISHED=$(date -d @"${i##PUBLISHED:}")
                ;;
            EOF*)
                echo -e "$TITLE\n$DESCRIPTION\n$PUBLISHED"
                ;;
        esac
        
    done
done | less
