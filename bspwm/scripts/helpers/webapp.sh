#!/usrbin/env bash
ARG1=$1
ARG2=$2

google-chrome-stable --app=$ARG1 --app-id=$ARG2 --new-window &

sleep 3
bspc node -t floating
xdotool search $ARG2 windowsize %@ 1700 1000 windowmove 100 30 set_window --class $ARG2
