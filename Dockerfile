FROM dorowu/ubuntu-desktop-lxde-vnc

# Instala Chromium y dependencias
RUN apt-get update && \
    apt-get install -y chromium-browser chromium-driver && \
    apt-get clean

# Establece Chromium como navegador por defecto y abre ChatGPT
RUN mkdir -p /etc/xdg/lxsession/LXDE && \
    echo '@chromium-browser --no-first-run --disable-features=TranslateUI --app=https://chat.openai.com' >> /etc/xdg/lxsession/LXDE/autostart

EXPOSE 80
CMD [ "/startup.sh" ]
