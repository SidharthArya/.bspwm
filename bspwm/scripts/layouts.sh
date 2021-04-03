#!/bin/sh

arg1=$1
bspc config external_rules_command ~/.config/bspwm/scripts/layouts/$arg1.sh
pkill -f ${arg1}_helper.sh
bash ~/.config/bspwm/scripts/layouts/${arg1}_helper.sh &
