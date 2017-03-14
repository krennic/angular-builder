FROM node:7.3

MAINTAINER krennic

ENV FIREFOX_VERSION=51.0


# Install npm and curl
RUN apt-get update && apt-get install -y --no-install-recommends\
    npm \
    xvfb \
    python-pip\
    && rm -rf /var/lib/apt/lists/* \
    && pip install selenium

RUN npm uninstall npm -g && npm install npm@latest -g && npm cache clean && rm -rf ~/.npm
RUN npm install -g @angular/cli@v1.0.0-rc.1 && npm cache clean && rm -rf ~/.npm


RUN echo 'deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu trusty main' > /etc/apt/sources.list.d//mozillateam-firefox-next-trusty.list &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE49EC21 &&\
    apt-get update &&\
    apt-get install -y firefox &&\
    rm -rf /var/lib/apt/lists/*

# install firefox for karma testing
RUN wget -q https://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/fr/firefox-${FIREFOX_VERSION}.tar.bz2 &&\
    tar xjf firefox-*.tar.bz2 &&\
    mv firefox /opt/firefox-${FIREFOX_VERSION}/ &&\
    rm firefox-*.tar.bz2 &&\
    ln -fs /opt/firefox-${FIREFOX_VERSION}/firefox /usr/bin/firefox



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
