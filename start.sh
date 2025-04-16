#!/bin/bash

export DISPLAY=:1

# Lanzar X virtual
Xvfb :1 -screen 0 1280x720x24 &
sleep 2

# Lanzar fondo gráfico (opcional, visible)
xsetroot -solid grey &

# Abrir navegador con ChatGPT
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Lanzar VNC sobre :1
x11vnc -display :1 -nopw -forever -shared -bg

# Lanzar NoVNC
exec /home/remoteuser/noVNC/utils/websockify/run --web /home/remoteuser/noVNC 80 localhost:5900
