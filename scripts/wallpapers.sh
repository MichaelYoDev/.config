#!/usr/bin/env bash
ls "$HOME/Wallpapers" | \
    sed 's/\.[^.]*$//' | \
    choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92" | \
    osascript -e 'tell application "Finder" to set desktop picture to POSIX file {}'
