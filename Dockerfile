FROM consol/ubuntu-xfce-vnc

# Instala Chromium
USER root
RUN apt-get update && \
    apt-get install -y chromium-browser && \
    apt-get clean

# Abre ChatGPT automáticamente al iniciar la sesión gráfica
RUN echo 'chromium-browser --no-first-run --kiosk https://chat.openai.com &' >> /root/.bashrc

EXPOSE 5901
