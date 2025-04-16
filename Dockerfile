# Dockerfile para navegador remoto con NoVNC y sesión congelada en ChatGPT
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y supervisor xfce4 xfce4-goodies x11vnc xvfb novnc websockify wget curl net-tools git python3 python3-pip chromium-browser && \
    apt-get clean

# Crea usuario de trabajo
RUN useradd -m remoteuser
USER remoteuser
WORKDIR /home/remoteuser

# Instala y configura NoVNC
RUN git clone https://github.com/novnc/noVNC.git && \
    git clone https://github.com/novnc/websockify noVNC/utils/websockify && \
    ln -s noVNC/vnc.html noVNC/index.html

# Script para iniciar el entorno
COPY start.sh /home/remoteuser/start.sh
RUN chmod +x /home/remoteuser/start.sh

# Configuración de Supervisor
USER root
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
