#!/usr/bin/env bash
all_args=("$@")
arg1=$1
arg2=$2
arg3="${all_args[@]:2}"
GDMSESSION="bspwm"
echo $arg2
case $arg1 in
		"title")
				id=$(xdo id -n $arg2)
				;;
		"class")
				id=$(xdo id -N "$arg2")
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
ID=$id

if [ "$ID" == "" ]
then
    exec $arg3
    exit 0
fi
CWD=$(bspc query -D -d last)
for id in $ID;
do
        NODE="$(echo $id| sed 's/.x.......1//g')"
        if [ "$(bspc query -N -d focused | grep $NODE | wc -l)" == "1" ];
        then
            bspc node $NODE -g hidden -d focused  -f
        else
            bspc node $NODE -g hidden=off -d focused  -f
        fi
        
done
CWD2=$(bspc query -D -d focused)
bspc desktop $CWD -f
bspc desktop $CWD2 -f
exit 1
