FROM node:7.3

MAINTAINER krennic

ENV FIREFOX_VERSION=52.0


# Install npm and curl
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    apt-transport-https \
    npm \
    xvfb \
    python-pip\
    && rm -rf /var/lib/apt/lists/* \
    && pip install selenium

RUN npm uninstall npm -g && npm install npm@latest -g && npm cache clean && rm -rf ~/.npm
RUN npm install -g @angular/cli@v1.0.0-rc.1 && npm cache clean && rm -rf ~/.npm

# install firefox for karma testing
RUN echo 'deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main' > /etc/apt/sources.list.d/mozilla.list &&\
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29 &&\
    apt-get update &&\
    apt-get install firefox-mozilla-build &&\
    rm -rf /var/lib/apt/lists/*

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
