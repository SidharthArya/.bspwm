#!/bin/sh
arg1=$1
OUT="CRYPTO:"
COUNTER=0
DEPTH="$(curl https://api.wazirx.com/api/v2/depth?market=$arg1)"
ASKS="$(echo $DEPTH | jq '.asks [] |@sh' | tr -d \"\')"
BIDS="$(echo $DEPTH | jq '.bids [] | @sh' | tr -d \"\')"
COUNT=$(echo "$ASKS" | wc -l)
MAX=$(echo "$ASKS $BIDS" | awk '{print $2}' | sort | tr -d \' | paste -sd + | bc | paste <(echo "$COUNT") / | bc )
OUTPUT=$(paste <(printf "^bg(#050)%.0s\n" {1..16}) <(echo "$BIDS" | awk '{print $2}') <(printf "^fg(#0F0)\n%.0s" {1..16}) <(echo "$BIDS" | awk '{print $2}' | dbar  -max $MAX | cut -c 6- | rev) <(printf "^fg()\n%.0s" {1..16}) <(echo "$BIDS" | awk '{print $1}') <(printf "^bg()^bg(#500)%.0s\n" {1..16}) <(echo "$ASKS" | awk '{print $1}') <(printf "^fg(#0F0)\n%.0s" {1..16}) <(echo "$ASKS" | awk '{print $2}' | dbar -max $MAX | cut -c 6-) <(printf "^fg()\n%.0s" {1..16}) <(echo "$ASKS" | awk '{print $2}') <(printf "^bg()%.0s\n" {1..16}))
echo -e "MARKET DEPTH\n$OUTPUT" | dzen2 -p 1 -ta c -sa c -m -l 20

