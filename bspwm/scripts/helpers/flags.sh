#!/bin/sh
MARKED_NORMAL_BORDER_COLOR="#550000"
MARKED_ACTIVE_BORDER_COLOR="#FF0000"
MARKED_NORMAL_BORDER_COLOR="#000055"
MARKED_ACTIVE_BORDER_COLOR="#0000FF"
while read -r line;
do
    NODE=$(echo $line |  cut -d' ' -f4)
    case "$line" in
        *'marked on')
            bspc config -n $NODE focused_border_color $MARKED_ACTIVE_BORDER_COLOR
            bspc config -n $NODE focused_border_color $MARKED_NORMAL_BORDER_COLOR
			;;
        *'marked on')
            bspc config -n $NODE focused_border_color $NORMAL_ACTIVE_BORDER_COLOR
            bspc config -n $NODE focused_border_color $NORMAL_NORMAL_BORDER_COLOR
			;;
    esac
done

