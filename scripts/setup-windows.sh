#!/bin/bash

export DISPLAY=:99

# Wait for X server to be ready
sleep 3

# Maximize DOSBox window
wmctrl -r "DOSBox" -b add,maximized_vert,maximized_horz

# If that doesn't work, try to resize it manually
wmctrl -r "DOSBox" -e 0,10,10,1600,1000

# Move DOSBox to front
wmctrl -r "DOSBox" -b add,above

echo "Window setup complete"
