# zen.sh
A shell script meditation timer for macOS. The script should also work on Linux with only minimal changes (just replace `afplay` with whatever command-line mp3 player you have on your system).

To begin a session simply run the script along with the number of minutes you wish to practice for. For example, to start a 30 minute session:

    zen.sh 30

If you don't specify how long the session should be, the default length of 60 minutes will be used.

The script shows a progress bar, and will play a bell every 10 minutes. At the end of the session a different bell will sound.

To turn off the interval bell, change the line

    PLAY_INTERVAL_BELL=true
to

    PLAY_INTERVAL_BELL=false

The script records how long you have practiced for, and will display your current total at the end of each session.

If you need to finish a session early press `Ctrl+C`, your time will still be recorded.