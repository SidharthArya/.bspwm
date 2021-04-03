#!/bin/sh

{
    pkill trayer &&
    bspc config bottom_padding 0
} || {
    bspc config bottom_padding 30  && trayer &
    sleep 2;
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $(xdo id -N trayer)
                }


