#!/bin/bash

export DISPLAY=:1
Xvfb :1 -screen 0 1280x720x24 &
sleep 2

# D-Bus
eval $(dbus-launch)

# Lanzar escritorio XFCE
startxfce4 &

sleep 5

# Abrir ChatGPT en Chromium
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Lanzar VNC conectado a la pantalla virtual
x11vnc -display :1 -nopw -forever -shared -bg

# NoVNC expuesto por web
exec /home/remoteuser/noVNC/utils/websockify/run --web /home/remoteuser/noVNC 80 localhost:5900
