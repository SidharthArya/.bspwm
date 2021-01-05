#!/bin/sh
HEIGHT=24
screenWidth=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | sed "s/x.*//")
screenHeight=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | egrep -o "x[0-9]*" | sed "s/x//")
WIDTH=$SCREENWIDTH
echo $WIDTH
POSITION=$1
SCREEN=$2
if [ "$POSITION" == "top" ];
then
    xpos=-$WIDTH
    ypos=0
    width=1920
    height=$HEIGHT
else
    xpos=0
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
font="NotoSansMono:size=10:antialias=true"
colRed500='#f44336'
colYellow500='#ffeb3b'
colBlue500='#2196f3'
parameters="  -x $xpos -y $ypos -h $height -w $width" 
parameters+=" -fn $font"
parameters+=" -ta l -bg $bgcolor -fg $fgcolor"
parameters+=" -title-name dzentop -dock -xs $SCREEN"
mkfifo /tmp/bspwm_finance_panel

sh ~/.config/bspwm/scripts/panel/crypto.sh  &
sh ~/.config/bspwm/scripts/panel/zerodha.sh  &
while read -r line
      do
          case $line in
              CRYPTO:*)  CRYPTO=${line##CRYPTO:}
                       ;;
              NSE:*)  NSE=${line##NSE:}
                       ;;
              ZERODHA:*)  ZERODHA=${line##ZERODHA:}
                       ;;
              *) ;;
          esac
          echo "$CRYPTO $NSE"
                  
done < <(tail -f /tmp/bspwm_finance_panel) | dzen2 $parameters 
