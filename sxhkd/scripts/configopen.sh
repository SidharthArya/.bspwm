#!/usr/bin/env bash
arg1=$1
IFS=$'\n'
EDITOR="emacsclient -n"
DMENU_COMMAND="rofi"
DMENU_COMMAND_ARGS="-dmenu"
if [[ "$arg1" == "" ]];
then
    cat ~/.config/sxhkd/scripts/configopen.sh | grep ^\s*.*\)$ | tr -d "\)* " | $DMENU_COMMAND $DMENU_COMMAND_ARGS | xargs -I{} sh ~/.config/sxhkd/scripts/configopen.sh {}
else
case $arg1 in
    bspwm)
        echo ~/.config/bspwm/bspwmrc
        ;;
    sxhkd)
        echo ~/.config/sxhkd/sxhkdrc
        ;;
    xmonad)
        echo ~/.xmonad/xmonad.hs
        ;;
    emacs)
        echo ~/.emacs.d/init.org
        ;;
    drill)
        echo ~/Documents/Org/Drill/drill.el
        ;;
    zathura)
        echo ~/.config/zathura/zathurarc
        ;;
    dunst)
        echo ~/.config/dunst/dunstrc
        ;;
    tracking)
        echo ~/Documents/Org/Personal/tracking.el
        ;;
    polybar)
        echo ~/.config/polybar/config
        ;;
    rofi)
        echo ~/.config/rofi/config.rasi
        ;;
esac | xargs -I{} emacsclient -n {}
fi
