#!/bin/bash

export DISPLAY=:1

# Iniciar Xvfb (pantalla virtual)
Xvfb :1 -screen 0 1280x720x24 &

# Esperar a que se inicie bien
sleep 2

# Fondo gris para evitar pantalla negra
xsetroot -solid grey &

# Iniciar entorno gráfico (fluxbox)
fluxbox &

# Abrir ChatGPT en Chromium
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Iniciar VNC
x11vnc -display :1 -nopw -forever -shared -bg

# Iniciar NoVNC escuchando en el puerto 10000
/home/remoteuser/noVNC/utils/websockify/run 10000 localhost:5900 --web /home/remoteuser/noVNC
