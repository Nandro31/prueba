#!/bin/bash

# Iniciar entorno gráfico virtual
Xvfb :1 -screen 0 1024x768x16 &
export DISPLAY=:1

# Iniciar XFCE
startxfce4 &

# Espera un poco para que todo se levante
sleep 5

# Iniciar VNC en background
x11vnc -display :1 -nopw -forever -shared -bg

# Abrir ChatGPT en Chromium
chromium-browser --no-first-run --app=https://chat.openai.com &

# Iniciar NoVNC manualmente con websockify
cd /home/remoteuser/noVNC
./utils/websockify/run --web . 80 localhost:5900
