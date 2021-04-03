#!/usr/bin/env bash
while read -r line;
do
    echo $line
    case ${line%% *} in
        node_add)
            bspc node @/2 -B;
            bspc node -s biggest.local;
            echo Adding
            ;;
        node_remove)
            bspc node @/ -i
            bspc node focused -n $(bspc query -N -n .local.leaf.\!window);
            echo Removing
            ;;
        node_flag)
            flag=$(echo $line | awk '{print $5}') 
            state=$(echo $line | awk '{print $6}')
            echo $flag $state
            if [[ $flag == "hidden" ]];
            then
            WINDOWS=$(bspc query -N -d focused -n .window.leaf.\!hidden | wc -l)
            echo $WINDOWS
            case $state in
                "on")
                    if [[ $WINDOWS -gt 0 ]];
                    then
                    bspc node @/ -i
                    bspc node focused -n $(bspc query -N -n .local.leaf.\!window);
                    fi
                    echo Removing
                    ;;
                "off")
                    bspc node @/2 -i
                    bspc node focused -n $(bspc query -N -n .local.leaf.\!window);
                    bspc node @/2 -B;
                    bspc node -s biggest.local;
                    echo Adding
            ;;
            esac
            fi
    esac
done < <(bspc subscribe node_add node_remove node_flag)
