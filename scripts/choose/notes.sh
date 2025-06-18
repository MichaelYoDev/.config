#!/usr/bin/env bash

NOTES_DIR="$HOME/Notes/QuickNotes"
mkdir -p "$NOTES_DIR"
NOTE_FILE="$NOTES_DIR/$(date '+%Y-%m-%d_%H-%M-%S').md"

{
  echo "# Quick Note - $(date '+%Y-%m-%d %H:%M:%S')"
  echo
} > "$NOTE_FILE"

ESCAPED_NOTE_FILE=$(printf '%q' "$NOTE_FILE")

osascript <<EOF
delay 1

on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

if not is_running("kitty") then
	tell application "kitty" to activate
else
	tell application "System Events" to tell process "kitty"
		click menu item "New OS Window" of menu 1 of menu bar item "Shell" of menu bar 1
	end tell
end if

delay 0.2

tell application "System Events"
    keystroke "nvim "
    keystroke "$NOTE_FILE"
    key code 36 -- press return
end tell
EOF
