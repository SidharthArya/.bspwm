#!/bin/sh
TEXT="$(xsel -p)"
if [ -z "$TEXT" ];
then
   TEXT="$(xsel -b)"
fi
   
bspc node -t fullscreen
echo "$TEXT" | speedread -w 200
