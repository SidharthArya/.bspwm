#!/bin/sh
browser="surf"
ROFI="rofi"
ROFIARGS=" -dmenu -theme Pop-Dark -font 'Noto Sans 14' "
export IFS=$'\n'
arg2=$(/usr/bin/ls -d /home/arya/Documents/Org/Brain/Learning/*/ | rofi -dmenu -theme Pop-Dark -font 'Noto Sans 14' -pSubject)
LINK=$(fd .org $arg2 | xargs rg -I "http"  | sed 's/^\s*+\s*//g' | rofi -dmenu -theme Pop-Dark -font 'Noto Sans 14' -p "bookmark")
if ! [ -z "$LINK" ];
then
	$browser $LINK
fi
