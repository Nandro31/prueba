#!/bin/bash

# Lanzar servidor gráfico virtual
Xvfb :1 -screen 0 1024x768x24 &
export DISPLAY=:1

# Esperar a que Xvfb se inicie correctamente
sleep 3

# Lanzar servicio dbus necesario para XFCE
dbus-launch --exit-with-session &

# Lanzar XFCE
startxfce4 &

# Esperar a que cargue el entorno de escritorio
sleep 5

# Iniciar VNC (conexión a Xvfb)
x11vnc -display :1 -nopw -forever -shared -bg

# Esperar antes de abrir navegador
sleep 5

# Abrir ChatGPT
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Lanzar NoVNC
cd /home/remoteuser/noVNC
./utils/websockify/run --web /home/remoteuser/noVNC 80 localhost:5900
