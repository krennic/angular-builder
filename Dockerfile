FROM node:7.3

MAINTAINER krennic

# Install npm and curl
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    npm \
    xvfb \
    python-pip\
    iceweasel\
    libgtk-3-0\
    libdbus-glib-1-2\
    && rm -rf /var/lib/apt/lists/* \
    && pip install selenium

#RUN npm install npm@latest -g && npm cache clean && rm -rf ~/.npm
#RUN npm install -g @angular/cli@v1.0.0-rc.1 && npm cache clean && rm -rf ~/.npm

# install firefox for karma testing
RUN wget https://ftp.mozilla.org/pub/firefox/releases/52.0/linux-x86_64/fr/firefox-52.0.tar.bz2 &&\
    tar xjf firefox-*.tar.bz2 &&\
    mv firefox /opt/firefox-52.0/ &&\
    rm firefox-*.tar.bz2 &&\
    ln -fs /opt/firefox-52.0/firefox /usr/bin/firefox

#Add virtual screen
ADD xvfb.init /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /etc/init.d/xvfb && \
    chmod +x /entrypoint.sh &&\
    update-rc.d xvfb defaults

WORKDIR /workspace

EXPOSE 4200

ENV DISPLAY :10

ENTRYPOINT ["/entrypoint.sh"]
