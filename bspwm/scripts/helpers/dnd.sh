ARG1="$1"

[[ -z $ARG1 ]] && MODE="Do not Disturb" || MODE="$ARG1"
if [[ -f /tmp/dnd_mode ]];
then
    kill $(cat /tmp/dnd_mode)
    rm /tmp/dnd_mode
    dunstctl set-paused false
    notify-send "$MODE Mode Killed"
else
    echo $$ >> /tmp/dnd_mode
    if $(dunstctl is-paused);
    then notify-send "$MODE Mode Disabled"; 
    else notify-send "$MODE Mode Enabled" && sleep 5; fi && dunstctl set-paused toggle
    rm /tmp/dnd_mode
fi