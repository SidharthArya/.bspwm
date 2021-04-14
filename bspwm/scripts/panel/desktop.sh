#!/usr/bin/env bash
HEIGHT=24
screenWidth=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | sed "s/x.*//")
screenHeight=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | egrep -o "x[0-9]*" | sed "s/x//")
monitorbgcolor=$fgcolor
monitorfgcolor=$bgcolor
workspaceactive=$bluecolor
workspaceocbginactive="#dddddd"
workspaceocfginactive=$fgdarkcolor
workspacebginactive="#aaaaaa"
workspacefginactive=$fgcolor
POSITION=$1
SCREEN=$2
if [ $SCREEN == '1' ];
then
    WIDTH=960
else
    WIDTH=$screenWidth
fi

if [ "$POSITION" == "top" ];
then
    xpos=0
    ypos=0
    width=$WIDTH
    height=$HEIGHT
else
    xpos=0
    ypos=$screenHeight
    width=$WIDTH
    height=$HEIGHT
fi
parameters="  -x $xpos -y $ypos -h $height -w $width" 
parameters+=" -fn $font"
parameters+=" -ta l -bg $bgcolor -fg $fgcolor"
parameters+=" -title-name dzentop -dock -xs $SCREEN"
while read -r line;
do
    text=""
    for i in $(echo $line | cut -c 2- | sed 's/\:/\n/g');
    do
        
        case $i in
            M*)
                text+="^bg($monitorbgcolor)^fg($monitorfgcolor) $(echo $i | cut -b 2- ) "
                ;;
            m*)
                text+="^bg()^fg()^ca(1,bspc monitor $(echo $i | cut -b 2-) -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            f*)
                text+="^bg($bgcolor)^fg($workspacefginactive)^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            F*)
                text+="^bg($colBlue500)^fg($workspaceocfginactive)^ca(1, bspc desktop ${i:1}) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            o*)
                text+="^bg($workspaceinactive)^fg()^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            O*)
                text+="^bg($workspaceactive)^fg()^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
             L*)   
                text+="^bg(#ff55aa)^fg(#000000)^ca(1,bspc desktop -l next) $(echo $i | cut -b 2- ) ^ca()"
                ;;
             G*)   
                text+="^bg(#123456)^fg(#ffffff)^ca(1, bspc node focused -g marked)^ca(2, bspc node focused -g sticky)^ca(3, bspc node focused -g private) f $(echo $i | cut -b 2- )  ^ca()^ca()^ca()"
                ;;
        esac
	text+="^fg()^bg()"
    done
    text+="^bg()^fg() $(xtitle) ^fg()^bg()"
    echo $text
done < <(bspc subscribe report)  | dzen2 $parameters

