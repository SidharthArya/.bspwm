#!/bin/sh
DOWN="#FF0000"
UP="#00FF00"
python ~/.config/bspwm/scripts/panel/assets/python/stock_index_info.py > /tmp/bspwm_finance_panel
# if [[ $(date +"%H%M") > 1530 ]];
# then
#     break
# fi
