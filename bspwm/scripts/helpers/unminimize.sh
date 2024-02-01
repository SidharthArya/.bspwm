#!/bin/sh
export IFS=$'\n'
case "$1" in
	"list")
		for id in $(bspc query -N -n .hidden);
		do 
		NAME="$(xprop -id $id | grep ^WM_NAME | awk -F\= '{print $NF}' | tr -d \")"
		CLASS="$(xprop -id $id | grep ^WM_CLASS | awk -F\= '{print $NF}' | tr -d \")"
		echo $id $CLASS $NAME
	done | dmenu | awk '{print $1}' | xargs -I{} bspc node {} -g hidden -f
	;;
	"last")
            ID="$(tail -n1 /tmp/bspwm_minimize_stack)"
	    FILE="$(head -n -1 /tmp/bspwm_minimize_stack)"
            echo "$FILE" > /tmp/bspwm_minimize_stack
            bspc node $ID -g hidden=off -f
            	    ;;
	"cycle")
            ID="$(tail -n1 /tmp/bspwm_minimize_stack)"
	    FILE="$(head -n -1 /tmp/bspwm_minimize_stack)"
            CUR="$(bspc query -N -n focused)"
            bspc node -g hidden=on
            echo -e "$CUR\n$FILE" > /tmp/bspwm_minimize_stack
            bspc node $ID -g hidden=off -f
            	    ;;
esac


