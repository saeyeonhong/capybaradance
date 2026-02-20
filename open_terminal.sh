#!/bin/bash

#Open Ghostty at the project's working directory

open -a Ghostty --args "$(pwd)"

sleep 0.75

# Optional script to make the opened window fullscreen.
osascript <<EOD
    tell application "System Events" to tell process "Ghostty"
        delay 0.75
    end tell
EOD
