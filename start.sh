#!/bin/bash

# Configurar pantalla virtual
export DISPLAY=:1

# Lanzar servidor X virtual
Xvfb :1 -screen 0 1280x720x24 &
sleep 2

# Lanzar bus de sesiones
eval $(dbus-launch)

# Lanzar XFCE en segundo plano
startxfce4 &
sleep 3

# Lanzar VNC conectado a Xvfb
x11vnc -display :1 -nopw -forever -shared -bg

# Abrir navegador apuntando a ChatGPT
chromium-browser --no-sandbox --no-first-run --disable-infobars --app=https://chat.openai.com &

# Iniciar NoVNC y dejarlo corriendo
exec /home/remoteuser/noVNC/utils/websockify/run --web /home/remoteuser/noVNC 80 localhost:5900
