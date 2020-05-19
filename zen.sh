#!/usr/bin/env bash

INTERVAL_BELL_URL=https://codebox.net/assets/audio/bell1.mp3
ENDING_BELL_URL=https://codebox.net/assets/audio/bell2.mp3

function play {
    URL_VAR=${1}_URL
    URL=${!URL_VAR}
    LOCAL_FILE=${1}.mp3
    if [ ! -f $LOCAL_FILE ]; then
        curl -s -o $LOCAL_FILE $URL
    fi
    afplay $LOCAL_FILE &
}

SESSION_LENGTH_MINUTES=25
INTERVAL_LENGTH_MINUTES=10
MINUTES=0

clear
play INTERVAL_BELL

while :; do
    sleep 60
    MINUTES=$((MINUTES + 1))
    if [ $MINUTES -eq $SESSION_LENGTH_MINUTES ]; then
        echo "+"
        break
    fi
    if [ $(( MINUTES % INTERVAL_LENGTH_MINUTES )) -eq 0 ]; then
        echo -n "+"
        play INTERVAL_BELL
    else
        echo -n "."
    fi
done

play ENDING_BELL
