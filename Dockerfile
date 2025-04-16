# Dockerfile para navegador remoto con NoVNC y ChatGPT
FROM dorowu/ubuntu-desktop-lxde-vnc

# Instala Google Chrome
RUN apt-get update && \
    apt-get install -y wget gnupg2 && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get clean

# Establece el navegador por defecto como Google Chrome
RUN echo 'google-chrome-stable' > /etc/skel/.config/lxsession/LXDE/autostart

# Abre automáticamente ChatGPT al iniciar
RUN echo '@google-chrome-stable --no-first-run --disable-features=TranslateUI --app=https://chat.openai.com' >> /etc/xdg/lxsession/LXDE/autostart

EXPOSE 80
CMD [ "/startup.sh" ]
