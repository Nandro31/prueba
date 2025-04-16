#!/bin/bash

# Lanzar servidor gráfico virtual
Xvfb :1 -screen 0 1024x768x24 &
export DISPLAY=:1

# Esperar a que Xvfb se inicie bien
sleep 5

# Lanzar escritorio XFCE
startxfce4 &
sleep 5

# Lanzar VNC
x11vnc -display :1 -nopw -forever -shared -bg

# Esperar un poco más antes del navegador
sleep 5

# Abrir ChatGPT en modo aplicación
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Lanzar NoVNC (asegúrate de que web root sea correcto)
cd /home/remoteuser/noVNC
./utils/websockify/run --web /home/remoteuser/noVNC 80 localhost:5900
