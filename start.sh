#!/bin/bash

# Pantalla virtual
export DISPLAY=:1
Xvfb :1 -screen 0 1280x720x24 &
sleep 2

# Dbus para que no falle entorno
eval $(dbus-launch)

# Lanzar algo visible aunque XFCE no funcione
xterm -geometry 80x24+200+200 -bg black -fg green &

# VNC
x11vnc -display :1 -nopw -forever -shared -bg

# NoVNC
/home/remoteuser/noVNC/utils/websockify/run --web /home/remoteuser/noVNC 80 localhost:5900
