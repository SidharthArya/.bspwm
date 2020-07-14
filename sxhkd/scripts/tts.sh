#!/bin/sh
export IFS=$'\n'; 
TTS_COMMAND="festival"
TTS_COMMAND_ARGS="--tts"
#"flite_cmu_us_slt"
case "$1" in
    start)
        for i in "$(xsel | sed 's/\./\.\n/g')"; 
        do
            while [[ -f /tmp/tts-play ]];
            do
                sleep 2;
            done
            touch /tmp/tts-play
            while [[ -f /tmp/tts-pause ]];
            do
                sleep 2;
            done
            echo "$i" | $TTS_COMMAND $TTS_COMMAND_ARGS;
            rm /tmp/tts-play
        done
        ;;
    stop)  for i in "$(ps -ux | grep scripts/tts.sh | awk '{print $2}')";
           do
               kill "$i";
           done
           killall -s SIGKILL $TTS_COMMAND;
           
           rm /tmp/tts-pause;
           rm /tmp/tts-play;
           ;;
    pause) touch /tmp/tts-pause;
           ;;
    play) rm /tmp/tts-pause;
           ;;
esac
