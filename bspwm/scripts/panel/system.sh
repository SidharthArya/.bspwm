#!/bin/bash
HEIGHT=24
WIDTH=960
screenWidth=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | sed "s/x.*//")
screenHeight=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | egrep -o "x[0-9]*" | sed "s/x//")
POSITION=$1
SCREEN=$2
if [ "$POSITION" == "top" ];
then
    xpos=-$WIDTH
    ypos=0
    height=$HEIGHT
    width=$WIDTH
else
    xpos=-$WIDTH
    ypos=$screenHeight
    height=$HEIGHT
    width=$WIDTH
fi

parameters="  -x $xpos -y $ypos -h $height -w $width" 
parameters+=" -fn $font"
parameters+=" -ta r -bg $bgcolor -fg $fgcolor"
parameters+=" -title-name dzentop -dock -xs $SCREEN"
touch /tmp/bspwm_panel
BATTERY=""
CPU=""
DATE=""
TEMP=""
BRIGHTNESS=""
VOLUME=""
CRYPTO=""
while read -r line
      do
          case $line in
              BAT:*)  BATTERY=${line##BAT:}
                       ;;
              THERMAL:*)  TEMP=${line##THERMAL:}
                       ;;
              CPU:*)  CPU=${line##CPU:}
                       ;;
              MEM:*) MEM=${line##MEM:}
                     ;;
              DATE:*) DATE=${line##DATE:}
                      ;;
              BRIGHTNESS:*) BRIGHTNESS=${line##BRIGHTNESS:}
                            ;;
              # VOLUME:*) VOLUME=${line##VOLUME:}
              #           ;;
              CRYPTO:*) CRYPTO=${line##CRYPTO:}
                        ;;
              POINTS:*) POINTS=${line##POINTS:}
                        ;;
              # ASSETS:*) ASSETS=${line##ASSETS:}
              #           ;;
              
              *) ;;
          esac
          echo "$CRYPTO $POINTS $ASSETS $BRIGHTNESS $VOLUME $TEMP $BATTERY $CPU $MEM $DATE "
                  
done < <(tail -f /tmp/bspwm_panel) | dzen2 $parameters &

bash ~/.config/bspwm/scripts/panel/battery.sh  &
bash ~/.config/bspwm/scripts/panel/cpu.sh  &
bash ~/.config/bspwm/scripts/panel/date.sh  &
bash ~/.config/bspwm/scripts/panel/brightness.sh  &
bash ~/.config/bspwm/scripts/panel/points.sh  &
# bash ~/.config/bspwm/scripts/panel/assets.sh  &
# bash ~/.config/bspwm/scripts/panel/crypto.sh  &

fg 1
