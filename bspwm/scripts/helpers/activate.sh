#!/bin/sh
ARG1=$1
ARG2=$2
ARG=""
case "$ARG1" in
    "class")
        ARG+="-n "
        ;;
    "name")
        ARG+="-n "
        ;;
    "wname")
        ARG+="-a "
        ;;
esac

WINDOW=$(xdo id $ARG $ARG2)

bspc node $WINDOW -g hidden=off
xdo activate $WINDOW
    
