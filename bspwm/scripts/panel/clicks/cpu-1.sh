#!/bin/sh
export SUDO_ASKPASS=/home/arya/.local/scripts/askpass.sh 
CPUPOWER=$(sudo -A cpupower frequency-info)
X=$(xdotool getmouselocation | awk '{print $1}')
X=${X##*:}
X=$(( $X - 50 ))
export IFS=$'\n'
{
    frequency=$(echo "$CPUPOWER" | awk 'NR==12' | sed 's/.*\://g')
    # frequencies=$(cpupower frequency-info | grep "available frequency" )
    # frequencies=$(echo ${frequencies##*:} | sed 's/, /\n/g' | sed 's/ //g')
    frequencies=$(echo -e "400MHz\n500MHz\n600MHz\n700MHz\n800MHz\n900MHz\n1GHz\n1.1GHz\n1.2GHz\n1.3GHz\n1.4GHz\n1.5GHz\n1.6GHz\n1.7GHz\n1.8GHz\n1.9GHz\n2.0GHz\n2.1GHz")
    governors=$(cpupower frequency-info -g)
    governors=${governors##*:}
    governors=$(echo ${governors##*:} | sed 's/ /\n/g')
    echo -e "$frequency\n$frequencies\n$governors"
 }|
    dzen2 -p 1 -l 20 -x $(( $X -150 )) -w 300 -y 30 -m -e 'button1=menuprint;button3=exit;button4=scrollup:3;button5=scrolldown:3;entertitle=uncollapse;leaveslave=none' > /tmp/frequency-set
freq=$(cat /tmp/frequency-set)
for i in $freq
do
[ -z $i ] || SUDO_ASKPASS=/home/arya/.local/scripts/askpass.sh sudo -A sh ~/.local/scripts/cpufreq.sh $i
done
