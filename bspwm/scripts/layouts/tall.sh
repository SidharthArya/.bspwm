#!/bin/sh

wid=$1
class=$2
instance=$3
consequences=$4
WINDOWS=$(bspc query -N -d focused -n .window.leaf.\!hidden | wc -l)
COUNT=0
# notify-send "$WINDOWS"
case $WINDOWS in
    0);;
    1)
        echo node=@ split_dir=west
        ;;
    *)
        echo node=@/2 split_dir=north
        #bspc node @/2 -B
        #bspc node -s biggest.local
esac
        
        
