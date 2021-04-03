#!/bin/sh

CONTENT=$(curl -i -H "user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" -H "referer: https://www.tradingview.com/"  -H "origin: https://www.tradingview.com" "https://news-headlines.tradingview.com/headlines/?category=stock&client=web&country=US&lang=en&locale=en&proSymbol=NSE%3ARELIANCE" | tail -n +15| jq ',[] | "\(.title) \(.shortDescription) \(.published)"')
echo $CONTENT

