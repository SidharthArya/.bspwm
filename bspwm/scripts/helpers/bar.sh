#!/bin/bash

pkill -f bspwm/scripts/panel && pkill trayer && {
    bspc config top_padding 0 && bspc config bottom_padding 0
     } || bash ~/.config/bspwm/scripts/panel.sh
