FROM dorowu/ubuntu-desktop-lxde-vnc

# Instala dependencias y Google Chrome
RUN apt-get update && \
    apt-get install -y wget gnupg2 curl software-properties-common && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get clean

# Establece el navegador por defecto como Google Chrome
RUN mkdir -p /etc/xdg/lxsession/LXDE && \
    echo '@google-chrome-stable --no-first-run --disable-features=TranslateUI --app=https://chat.openai.com' >> /etc/xdg/lxsession/LXDE/autostart

EXPOSE 80
CMD [ "/startup.sh" ]
