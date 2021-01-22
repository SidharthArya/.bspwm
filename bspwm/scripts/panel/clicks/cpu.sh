#!/bin/sh

X=$(xdotool getmouselocation | awk '{print $1}')
X=${X##*:}
X=$(( $X - 50 ))
PS="$(ps -eo pcpu,comm,pid | tail -n +2)"
{
    echo "%CPU PROGRAM"
    echo "$PS" | sort -n -r | head -n 10 | awk '{print "^ca(1, kill " $3 ")" $1 "\ " $2 "^ca()"}' 

}|
    dzen2 -p 1 -l 10 -x $(( $X -150 )) -w 300 -y 30 -m -e 'button1=menuprint;button3=exit;button4=scrollup:3;button5=scrolldown:3;entertitle=uncollapse;leaveslave=none'

