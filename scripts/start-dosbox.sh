#!/bin/bash

# Start Xvfb (virtual display)
export DISPLAY=:99
Xvfb :99 -screen 0 1920x1080x24 &
sleep 2

# Start window manager
fluxbox &
sleep 2

# Start VNC server (allow external connections)
x11vnc -display :99 -nopw -listen 0.0.0.0 -xkb -ncache 10 -ncache_cr -forever -shared &

# Start DOSBox
dosbox -conf /root/.dosbox/dosbox-0.74-3.conf
