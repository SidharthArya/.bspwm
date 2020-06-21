#!/bin/sh

MONITORS="$(bspc query -M --names)"
ARG1="$1"
FOCUSED_MONITOR="$(bspc query --names -M -m focused)"
for monitr in $MONITORS
do
	FOCUSED="$(bspc query --names -D -d $monitr:focused)"
	echo $FOCUSED
	if [[ "$FOCUSED" == "$ARG1" ]];
	then
		MONITOR="$monitr"

	fi
done
		echo "$MONITOR"

if [[ "$MONITOR" == "" ]];
then
	bspc desktop "$ARG1" -m focused 
	bspc desktop "$ARG1" -f
else
	FOCUSED_DESKTOP="$(bspc query --names -D -d focused)"
	echo $FOCUSED_DESKTOP
	bspc desktop "$FOCUSED_DESKTOP" -m "$MONITOR" 
	bspc desktop "$ARG1" -m "$FOCUSED_MONITOR" 
	bspc desktop "$FOCUSED_DESKTOP" -f
	bspc desktop "$ARG1" -f
fi



