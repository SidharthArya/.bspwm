#!/bin/sh

xpos=-960
ypos=0
width=960
height=24
fgcolor="#000000"
bgcolor="#ffffff"
monitorbgcolor="#005500"
monitorfgcolor="#ffffff"
workspaceactive="#0000ff"
workspaceocbginactive="#dddddd"
workspaceocfginactive="#333333"
workspacebginactive="#aaaaaa"
workspacefginactive="#555555"
font="NotoSansMono:size=12:antialias=true"
colRed500='#f44336'
colYellow500='#ffeb3b'
colBlue500='#2196f3'
parameters="  -x $xpos -y $ypos -h $height -w $width" 
parameters+=" -fn $font"
parameters+=" -ta r -bg $bgcolor -fg $fgcolor"
parameters+=" -title-name dzentop -dock"


mkfifo /tmp/bspwm_panel
BATTERY=""
CPU=""
DATE=""
TEMP=""

sh ~/.config/bspwm/scripts/panel/battery.sh  &
sh ~/.config/bspwm/scripts/panel/cpu.sh  &
sh ~/.config/bspwm/scripts/panel/date.sh  &
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
              *) ;;
          esac
          echo "$TEMP $BATTERY $CPU $MEM $DATE "
                  
done < <(tail -f /tmp/bspwm_panel) | dzen2 $parameters
