#!/usr/bin/env bash
HEIGHT=24
screenWidth=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | sed "s/x.*//")
screenHeight=$(xdpyinfo | grep 'dimensions' | egrep -o "[0-9]+x[0-9]+ pixels" | egrep -o "x[0-9]*" | sed "s/x//")
monitorbgcolor=$fgcolor
monitorfgcolor=$bgcolor
monitorbgcolorinactive="#555"
monitorfgcolorinactive="#999"
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
declare -A workspaces
while read -r line;
do
    mcount=0
    dcount=0
    wrest=""
    monitor=""
    text=""
    for i in $(echo $line | cut -c 2- | sed 's/\:/\n/g');
    do
        
        case $i in
            M*)
                mcount=$(( $mcount + 1 ))
                monitor+="^bg($monitorbgcolor)^fg($monitorfgcolor) $(echo $i | cut -b 2- ) "
                ;;
            m*)
                mcount=$(( $mcount + 1 ))
                monitor+="^bg($monitorbgcolorinactive)^fg($monitorfgcolorinactive)^ca(1,bspc monitor $(echo $i | cut -b 2-) -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            f*)
                [ ${i:1} -lt 10 ] 2>/dev/null && workspaces[${i:1}]="^bg($bgcolor)^fg($workspacefginactive)^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()" || wrest+="^bg($bgcolor)^fg($workspacefginactive)^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            F*)
                [ ${i:1} -lt 10 ] 2>/dev/null && workspaces[${i:1}]="^bg($colBlue500)^fg($workspaceocfginactive)^ca(1, bspc desktop ${i:1}) $(echo $i | cut -b 2- ) ^ca()" || wrest+="^bg($colBlue500)^fg($workspaceocfginactive)^ca(1, bspc desktop ${i:1}) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            o*)
                [ ${i:1} -lt 10 ] 2>/dev/null && workspaces[${i:1}]="^bg($workspaceinactive)^fg()^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()" || wrest+="^bg($workspaceinactive)^fg()^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            O*)
                [ ${i:1} -lt 10 ] 2>/dev/null && workspaces[${i:1}]="^bg($workspaceactive)^fg()^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()" || wrest+="^bg($workspaceactive)^fg()^ca(1, bspc desktop ${i:1} -f) $(echo $i | cut -b 2- ) ^ca()"
                ;;
            L*)
                [[ $mcount == $SCREEN ]] && text+="^bg(#ff55aa)^fg(#000000)^ca(1,bspc desktop -l next) $(echo $i | cut -b 2- ) ^ca()"
                ;;
             G*)   
                [[ $mcount == $SCREEN ]] && text+="^bg(#123456)^fg(#ffffff)^ca(1, bspc node focused -g marked)^ca(2, bspc node focused -g sticky)^ca(3, bspc node focused -g private) f $(echo $i | cut -b 2- )  ^ca()^ca()^ca()"
                ;;
        esac
	text+="^fg()^bg()"
    done
    wtext=""
    for j in {1..9};
    do
        wtext+="${workspaces[$j]}"
    done
    wtext+="${workspaces[0]}"
    wtext+=$wrest
    text+="^bg()^fg() $(xtitle) ^fg()^bg()"
    echo $monitor $wtext $text
done < <(bspc subscribe report)  | dzen2 $parameters

