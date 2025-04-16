FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias principales
RUN apt-get update && \
    apt-get install -y supervisor xfce4 xfce4-goodies x11vnc xvfb novnc websockify wget curl net-tools git python3 python3-pip chromium-browser && \
    apt-get clean

# Crear usuario
RUN useradd -m remoteuser

# Copiar archivos y configurar entorno antes de cambiar de usuario
COPY start.sh /home/remoteuser/start.sh
RUN chmod +x /home/remoteuser/start.sh && chown remoteuser:remoteuser /home/remoteuser/start.sh

# Instalar NoVNC en el home del usuario
RUN git clone https://github.com/novnc/noVNC.git /home/remoteuser/noVNC && \
    git clone https://github.com/novnc/websockify /home/remoteuser/noVNC/utils/websockify && \
    ln -s /home/remoteuser/noVNC/vnc.html /home/remoteuser/noVNC/index.html && \
    chown -R remoteuser:remoteuser /home/remoteuser/noVNC

# Cambiar al usuario creado
USER remoteuser
WORKDIR /home/remoteuser

# Copiar configuración de Supervisor (como root)
USER root
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exponer el puerto web para NoVNC
EXPOSE 80

# Iniciar supervisor
CMD ["/usr/bin/supervisord"]
