#!/bin/sh
xdo kill -n firefox;
for node in $(bspc query -N); do 
	bspc node $node -c;
done

while [[ $(bspc query -N | wc -l) > 0 ]];
do
    sleep 5;
done
fusermount -u ~/Documents;
st -e sh ~/.local/scripts/sync.sh;
