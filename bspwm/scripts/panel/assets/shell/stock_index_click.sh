#!/bin/sh
X=$(xdotool getmouselocation | awk '{print $1}')
X=${X##*:}
X=$(( $X - 50 ))
echo $1 | dzen2 -p 2 -w 100 -x $X -y -60 -fg '#000' -bg '#fff' 

