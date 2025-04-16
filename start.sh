#!/bin/bash

export DISPLAY=:1

# Lanzar Xvfb (pantalla virtual)
Xvfb :1 -screen 0 1280x720x24 &
sleep 2

# Fondo gris para confirmar que se renderiza algo
xsetroot -solid grey &

# Iniciar entorno gráfico mínimo (fluxbox)
fluxbox &

# Esperar unos segundos más
sleep 3

# Lanzar VNC conectado a Xvfb
x11vnc -display :1 -nopw -forever -shared -bg
sleep 2

# Lanzar Chromium con ChatGPT
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Lanzar NoVNC Websockify en puerto 10000
exec /home/remoteuser/noVNC/utils/websockify/run 10000 localhost:5900 --web /home/remoteuser/noVNC
