#!/bin/sh
HEIGHT=24
WIDTH=960
screenWidth=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | sed "s/x.*//")
screenHeight=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | egrep -o "x[0-9]*" | sed "s/x//")
POSITION=$1
if [ "$POSITION" == "top" ];
then
    xpos=-$WIDTH
    ypos=0
    width=1060
    height=$HEIGHT
else
    xpos=-$WIDTH
    ypos=$screenHeight
    width=960
    height=$HEIGHT
fi
fgcolor="#000000"
bgcolor="#ffffff"
monitorbgcolor="#005500"
monitorfgcolor="#ffffff"
workspaceactive="#0000ff"
workspaceocbginactive="#dddddd"
workspaceocfginactive="#333333"
workspacebginactive="#aaaaaa"
workspacefginactive="#555555"
font="NotoSansMono:size=9:antialias=true"
colRed500='#f44336'
colYellow500='#ffeb3b'
colBlue500='#2196f3'
parameters="  -x $xpos -y $ypos -h $height -w $width" 
parameters+=" -fn $font"
parameters+=" -ta r -bg $bgcolor -fg $fgcolor"
parameters+=" -title-name dzentop -dock"


touch /tmp/bspwm_panel
BATTERY=""
CPU=""
DATE=""
TEMP=""
BRIGHTNESS=""
VOLUME=""
CRYPTO=""
sh ~/.config/bspwm/scripts/panel/battery.sh  &
sh ~/.config/bspwm/scripts/panel/cpu.sh  &
sh ~/.config/bspwm/scripts/panel/date.sh  &
sh ~/.config/bspwm/scripts/panel/brightness.sh  &
sh ~/.config/bspwm/scripts/panel/points.sh  &
sh ~/.config/bspwm/scripts/panel/assets.sh  &
sh ~/.config/bspwm/scripts/panel/crypto.sh  &
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
              VOLUME:*) VOLUME=${line##VOLUME:}
                        ;;
              CRYPTO:*) CRYPTO=${line##CRYPTO:}
                        ;;
              POINTS:*) POINTS=${line##POINTS:}
                        ;;
              ASSETS:*) ASSETS=${line##ASSETS:}
                        ;;
              *) ;;
          esac
          echo "$CRYPTO $POINTS $ASSETS $BRIGHTNESS $VOLUME $TEMP $BATTERY $CPU $MEM $DATE "
                  
done < <(tail -f /tmp/bspwm_panel) | dzen2 $parameters -xs $1
