#!/bin/sh
export IFS=$'\n'
for id in $(bspc query -N -n .hidden);
do 
	NAME="$(xprop -id $id | grep ^WM_NAME | awk -F\= '{print $NF}' | tr -d \")"
	CLASS="$(xprop -id $id | grep ^WM_CLASS | awk -F\= '{print $NF}' | tr -d \")"
	echo $id $CLASS $NAME
done | dmenu | awk '{print $1}' | xargs -I{} bspc node {} -g hidden -f

