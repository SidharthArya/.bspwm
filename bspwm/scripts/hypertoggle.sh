#!/bin/sh

case $1 in
    init)
setxkbmap -layout us -option caps:hyper
setxkbmap -layout us -option print:super
xmodmap -e 'remove mod4 = Hyper_L'
xmodmap -e 'add mod3 = Hyper_L'
xmodmap -e 'add mod3 = Hyper_R'
xmodmap -e "keycode 250 = Print"
xmodmap -e "keycode 252 = Caps_Lock"
xmodmap -e "keycode 253 = Return"
xmodmap -e "keycode 107 = Super_R"
xmodmap -e "keycode 66 = Hyper_L"
xmodmap -e "keycode 36 = Hyper_R"
xcape -e 'Hyper_L=Caps_Lock;Hyper_R=Return;Super_L=Escape;Super_R=Print'
sxhkd -c ~/.config/bspwm/sxhkdrc
    ;;
    *)
pkill xcape && {
setxkbmap -layout us -option caps:caps
setxkbmap -layout us -option print:print
xmodmap -e 'remove mod4 = Hyper_L'
xmodmap -e 'add mod3 = Hyper_L'
xmodmap -e 'add mod3 = Hyper_R'
xmodmap -e "keycode 250 = NoSymbol"
xmodmap -e "keycode 252 = NoSymbol"
xmodmap -e "keycode 253 = NoSymbol"
xmodmap -e "keycode 107 = Print"
xmodmap -e "keycode 66 = Caps_Lock"
xmodmap -e "keycode 36 = Return"
} || {
setxkbmap -layout us -option caps:hyper
setxkbmap -layout us -option print:super
xmodmap -e 'remove mod4 = Hyper_L'
xmodmap -e 'add mod3 = Hyper_L'
xmodmap -e 'add mod3 = Hyper_R'
xmodmap -e "keycode 250 = Print"
xmodmap -e "keycode 252 = Caps_Lock"
xmodmap -e "keycode 253 = Return"
xmodmap -e "keycode 107 = Super_R"
xmodmap -e "keycode 66 = Hyper_L"
xmodmap -e "keycode 36 = Hyper_R"
xcape -e 'Hyper_L=Caps_Lock;Hyper_R=Return;Super_L=Escape;Super_R=Print'
}

pkill sxhkd && sxhkd -c ~/.config/bspwm/sxhkdrc &
esac

