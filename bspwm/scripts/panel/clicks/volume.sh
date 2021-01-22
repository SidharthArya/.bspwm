#!/bin/sh

X=$(xdotool getmouselocation | awk '{print $1}')
X=${X##*:}
X=$(( $X - 50 ))

( echo "Volume" && seq 0 10 150 ) | dzen2 -p 1 -l 10 -x $(( $X )) -w 100 -y 30 -m -e 'button1=menuprint;button3=exit;button4=scrollup:3;button5=scrolldown:3;entertitle=uncollapse;leaveslave=none' | xargs -I{} pamixer --set-volume {}
echo 1 > /tmp/bspwm_brightness_volume 
