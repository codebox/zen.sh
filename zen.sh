#!/usr/bin/env bash

INTERVAL_BELL_URL=https://codebox.net/assets/audio/bell1.mp3
ENDING_BELL_URL=https://codebox.net/assets/audio/bell2.mp3
MINUTE_MARKER=.
INTERVAL_MARKER=+

function play {
    URL_VAR=${1}_URL
    URL=${!URL_VAR}
    LOCAL_FILE=${1}.mp3
    if [ ! -f $LOCAL_FILE ]; then
        curl -s -o $LOCAL_FILE $URL
    fi
    afplay $LOCAL_FILE &
}

DEFAULT_SESSION_LENGTH_MINUTES=60
SESSION_LENGTH_MINUTES=${1:-$DEFAULT_SESSION_LENGTH_MINUTES}
INTERVAL_LENGTH_MINUTES=10
MINUTES=0

if [[ ! $SESSION_LENGTH_MINUTES =~ ^[1-9][0-9]*$ ]]; then
    echo "Usage: $0 [minutes]"
    exit 1
fi

clear
play INTERVAL_BELL

while :; do
    sleep 60
    MINUTES=$((MINUTES + 1))
    if [[ $MINUTES -eq $SESSION_LENGTH_MINUTES ]]; then
        echo $INTERVAL_MARKER
        break
    fi
    if [[ $(( MINUTES % INTERVAL_LENGTH_MINUTES )) -eq 0 ]]; then
        echo -n $INTERVAL_MARKER
        play INTERVAL_BELL
    else
        echo -n $MINUTE_MARKER
    fi
done

play ENDING_BELL
