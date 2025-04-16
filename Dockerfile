# Dockerfile optimizado para Render.com con navegador remoto
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias básicas + gráficos + navegador
RUN apt-get update && apt-get install -y \
    x11vnc xvfb fluxbox chromium-browser git curl wget python3 python3-pip net-tools \
    supervisor novnc websockify xterm xfonts-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear usuario
RUN useradd -m remoteuser
USER remoteuser
WORKDIR /home/remoteuser

# Instalar NoVNC
RUN git clone https://github.com/novnc/noVNC.git && \
    git clone https://github.com/novnc/websockify.git noVNC/utils/websockify && \
    ln -s noVNC/vnc.html noVNC/index.html

# Copiar script de inicio
COPY start.sh /home/remoteuser/start.sh
RUN chmod +x /home/remoteuser/start.sh

EXPOSE 10000
CMD ["/home/remoteuser/start.sh"]
