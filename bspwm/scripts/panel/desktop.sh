#!/bin/sh
xpos=0
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
parameters+=" -ta l -bg $bgcolor -fg $fgcolor"
parameters+=" -title-name dzentop -dock"
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
                text+="^bg()^fg() $(echo $i | cut -b 2- ) "
                ;;
            f*)
                text+="^bg($bgcolor)^fg($workspacefginactive) $(echo $i | cut -b 2- ) "
                ;;
            F*)
                text+="^bg($colBlue500)^fg($workspaceocfginactive) $(echo $i | cut -b 2- ) "
                ;;
            o*)
                text+="^bg($workspaceinactive)^fg(#000000) $(echo $i | cut -b 2- ) "
                ;;
            O*)
                text+="^bg($workspaceactive)^fg(#000000) $(echo $i | cut -b 2- ) "
                ;;
             L*)   
                text+="^bg(#ff55aa)^fg(#000000) $(echo $i | cut -b 2- ) "
                ;;
             G*)   
                text+="^bg(#123456)^fg(#ffffff) $(echo $i | cut -b 2- )  "
                ;;
        esac
    done
    text+="^bg()^fg()"
    echo $text
done < <(bspc subscribe report)  | dzen2 $parameters -xs $1
