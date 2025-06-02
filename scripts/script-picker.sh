#!/usr/bin/env bash

selection=$(
  ls "$HOME/.config/scripts" |
    sed 's/\.[^.]*$//' |
    choose -f "JetBrainsMono Nerd Font" -b "31748f" -c "eb6f92"
)

if [[ -n "$selection" ]]; then
  "$HOME/.config/scripts/${selection}.sh"
fi
