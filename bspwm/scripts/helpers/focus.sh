#!/usr/bin/env bash

ARG1=$1
ARG2=$2
ARG3=$3

function flashScreen (){
    xgamma -rgamma 0.1 && sleep 0.1 && xgamma -bgamma 0.1 && sleep 0.1 && xgamma -ggamma 0.1 && sleep 0.1 && xgamma -rgamma 1.0 && sleep 0.1 && xgamma -bgamma 1.0 && sleep 0.1 && xgamma -ggamma 1.0 
}
function flash (){
    fARG1=$1
    [[ $fARG1 != 'visual' ]] && mpv /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga &
    [[ $fARG1 != 'audio' ]] && flashScreen && sleep 1 && flashScreen && sleep 1 && flashScreen && sleep 1 && flashScreen
}
if [[ -f /tmp/focus_mode ]];
then
    kill $(cat /tmp/focus_mode)
    DT=$(stat /tmp/focus_mode | grep Birth | awk '{print $2" "$3}')
    DT="${DT%%.*}"
    DTD=$(echo $DT | awk '{print $1}')
    DT1=$(echo $DT | awk '{print $2}')
    DT2="$(date +%H:%M:%S)"
    difference=$(( $(date -d "$DT2" "+%s") - $(date -d "$DT1" "+%s")))
    MIN=$(echo "scale=2 ; $difference/60" | bc)
    echo $DTD,$DT1,$DT2,$MIN >> ~/Documents/Org/Tracking/focus.csv
    rm /tmp/focus_mode
    dunstctl set-paused false
    notify-send "Focus Mode Killed"
    flash $ARG3


else
    flash $ARG3
    echo $$ >> /tmp/focus_mode
    bash ~/.config/bspwm/scripts/helpers/dnd.sh 'Focus Mode'
    sleep $ARG1
    bash ~/.config/bspwm/scripts/helpers/dnd.sh 'Focus Mode'
    flash $ARG3
    notify-send "Focus Mode: Rest Time"
    sleep $ARG2
    DT=$(stat /tmp/focus_mode | grep Birth | awk '{print $2" "$3}')
    DT="${DT%%.*}"
    DTD=$(echo $DT | awk '{print $1}')
    DT1=$(echo $DT | awk '{print $2}')
    DT2="$(date +%H:%M:%S)"
    difference=$(( $(date -d "$DT2" "+%s") - $(date -d "$DT1" "+%s")))
    MIN=$(echo "scale=2 ; $difference/60" | bc)
    echo $DTD,$DT1,$DT2,$MIN >> ~/Documents/Org/Tracking/focus.csv
    rm /tmp/focus_mode
    flash $ARG3
fi
