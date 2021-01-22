#!/bin/sh

arg1=$1

python ~/.config/bspwm/scripts/panel/assets/python/stock_feed_parse.py $arg1  | dzen2 -p 1 -l 20 
