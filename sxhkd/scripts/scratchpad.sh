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
				bspc node $(echo $id| sed 's/.x.......1//g') -g hidden -d focused -f
fi
