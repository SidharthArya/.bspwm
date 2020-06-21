#!/bin/sh
for node in $(bspc query -N); do 
	bspc node $node -c;
done

