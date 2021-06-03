#!/usr/bin/env bash
while read -r line;
do
    echo $line
    case ${line%% *} in
        node_add)
            bspc node @/2 -B;
            bspc node -s biggest.local.\!hidden;
            echo Adding
            ;;
        node_remove)
            count=$(bspc query -N -d focused -n .window.\!hidden.\!floating | wc -l)
            bspc node @/2 -i
            check=$(bspc query -T -n @/2  | jq .secondChild.hidden)
            echo $check
            if [[ $check == "true" ]] || [[ $check == "null" ]];
            then
                bspc node prev.leaf.\!window -k
                bspc node focused -s biggest.local;
            else
                bspc node focused -s biggest.local;
                [[ "$count" -eq "2" ]] && bspc node focused -n prev.leaf.\!window || bspc node prev.leaf.\!window -k
                echo $count
            fi
            bspc node @/2 -B;
            echo Removing
            ;;
        node_flag)
            flag=$(echo $line | awk '{print $5}') 
            state=$(echo $line | awk '{print $6}')
            echo $flag $state
            # if [[ $flag == "hidden" ]];
            # then
            # WINDOWS=$(bspc query -N -d focused -n .window.leaf.\!hidden | wc -l)
            # echo $WINDOWS
            # case $state in
            #     "on")
            #         if [[ $WINDOWS -gt 0 ]];
            #         then
            #         bspc node @/ -i
            #         bspc node focused -n $(bspc query -N -n .local.leaf.\!window);
            #         fi
            #         echo Removing
            #         ;;
            #     "off")
            #         bspc node @/2 -i
            #         bspc node focused -n $(bspc query -N -n .local.leaf.\!window);
            #         bspc node @/2 -B;
            #         bspc node -s biggest.local;
            #         echo Unhiding
            # ;;
            # esac

            # fi
            ;;
            node_state)
            
            flag=$(echo $line | awk '{print $5}') 
            state=$(echo $line | awk '{print $6}')
            echo $flag $state
            if [[ $flag == "tiled" ]];
            then
                if [[ $state == "off" ]];
                then
                    bspc node @/1 -i
                    bspc node prev.local.window.\!floating.\!hidden -n prev.leaf.\!window 
                    bspc node @/2 -B;
                else
                    bspc node @/2 -i
                    bspc node focused -n $(bspc query -N -n .local.leaf.\!window);
                    bspc node -s biggest.local;
                    bspc node @/2 -B;
                fi
            fi
            ;;
    esac
done < <(bspc subscribe node_add node_remove node_state)
