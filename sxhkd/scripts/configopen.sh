#!/usr/bin/env bash
#
#
arg1=$1
IFS=$'\n'
EDITOR="emacsclient -n"
if [[ "$arg1" == "" ]];
then
    cat ~/.config/sxhkd/scripts/configopen.sh | grep ^\s*.*\)$ | tr -d "\)* " | dmenu | xargs -I{} sh ~/.config/sxhkd/scripts/configopen.sh {}
else
case $arg1 in
    bspwm)
        echo ~/.config/bspwm/bspwmrc
        ;;
    sxhkd)
        echo ~/.config/sxhkd/sxhkdrc
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
esac | xargs -I{} emacsclient -n {}
fi
