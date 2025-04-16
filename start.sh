#!/bin/bash

# Arranca servidor X virtual
Xvfb :1 -screen 0 1024x768x16 &

# Exporta la pantalla
export DISPLAY=:1

# Arranca XFCE
startxfce4 &

# Inicia VNC en modo view-only (opcional)
x11vnc -forever -usepw -display :1 -shared -bg

# Abre ChatGPT en Chromium (modo app)
chromium-browser --no-first-run --app=https://chat.openai.com &

# Inicia websockify para NoVNC
/home/remoteuser/noVNC/utils/launch.sh --vnc localhost:5900 --listen 80
