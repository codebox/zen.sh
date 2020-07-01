#!/usr/bin/env bash

INTERVAL_BELL_URL=https://codebox.net/assets/audio/bell1.mp3
ENDING_BELL_URL=https://codebox.net/assets/audio/bell2.mp3
MINUTE_MARKER=.
INTERVAL_MARKER=+
LOG_FILE=~/.zen_log

PLAY_INTERVAL_BELL=true

function play {
	LOCAL_FILE="${TMPDIR:-/tmp}/${1}.mp3"
    if [ ! -f "$LOCAL_FILE" ]; then
        URL_VAR=${1}_URL
        URL=${!URL_VAR}
        curl -s -o "$LOCAL_FILE" "$URL"
    fi
    afplay "$LOCAL_FILE" &
}

function print_time {
    PREFIX=$1
    MINUTES=$2
    echo "$PREFIX $(( MINUTES / 60 )) hours $(( MINUTES % 60 )) minutes"
}

function log {
    echo
    print_time "This session:" $MINUTES
    if [[ -f $LOG_FILE ]]; then
        PREV_MINUTES=$(<$LOG_FILE)
        NEW_MINUTES=$(( PREV_MINUTES + MINUTES ))
    else
        NEW_MINUTES=$MINUTES
    fi
    echo $NEW_MINUTES > $LOG_FILE
    print_time "All sessions:" $NEW_MINUTES
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

trap break SIGINT

while :; do
    sleep 60
    MINUTES=$((MINUTES + 1))
    if [[ $MINUTES -eq $SESSION_LENGTH_MINUTES ]]; then
        echo -n $INTERVAL_MARKER
        break
    fi
    if [[ $(( MINUTES % INTERVAL_LENGTH_MINUTES )) -eq 0 ]]; then
        echo -n $INTERVAL_MARKER
        $PLAY_INTERVAL_BELL && play INTERVAL_BELL
    else
        echo -n $MINUTE_MARKER
    fi
done

log $MINUTES

play ENDING_BELL
