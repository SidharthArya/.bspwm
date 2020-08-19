#!/usr/bin/env bash
all_args=("$@")
arg1=$1
arg2=$2
arg3="${all_args[@]:2}"
GDMSESSION="bspwm"
case $arg1 in
		"title")
				id=$(xdo id -n $arg2)
				;;
		"class")
				id=$(xdo id -N $arg2)
				;;

		"wclass")
				id=$(xdo id -a $arg2)
				;;
		*)
				echo "Wrong Option!"
				;;
esac

echo $id
echo $arg3

if [ "$id" == "" ]
 then
		 exec $arg3;
else
    NODE="$(echo $id| sed 's/.x.......1//g')"
    if [ "$(cat /tmp/wm)" == "bspwm" ];
    then
        if [ "$(bspc query -N -d focused | grep $NODE | wc -l)" == "1" ];
        then
            bspc node $NODE -g hidden -d focused  -f
        else
            bspc node $NODE -g hidden=off -d focused  -f
        fi
    else
        xdo hide $id;
        xdo show $id;
    fi
    
fi
