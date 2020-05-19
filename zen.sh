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

INTERVAL_LENGTH_MINUTES=10
INTERVAL_COUNT=6
MINUTES=0
INTERVALS=0

while :; do
    play INTERVAL_BELL
    sleep 5
    MINUTES=$((MINUTES + 1))
    if [ $MINUTES -eq $INTERVAL_LENGTH_MINUTES ]; then
        echo -n "+"
        INTERVALS=$((INTERVALS + 1))
        if [ $INTERVALS -eq $INTERVAL_COUNT ]; then
            break
        fi
        MINUTES=0
    else
        echo -n "."
    fi
done

play ENDING_BELL
exit 0

