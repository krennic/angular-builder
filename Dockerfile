FROM node:6.10.0

MAINTAINER krennic

ENV FIREFOX_VERSION=52.0
ENV ANGULAR_CLI_VERSION=v1.0.0-rc.1


# Install npm and curl
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    npm \
    xvfb \
    python-pip\
    firefox-esr\
    && rm -rf /var/lib/apt/lists/* \
    && pip install selenium

RUN npm uninstall npm -g && install npm@latest -g && npm cache clean && rm -rf ~/.npm
RUN npm install -g @angular/cli@${ANGULAR_CLI_VERSION} && npm cache clean && rm -rf ~/.npm

# install firefox for karma testing
RUN wget https://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/fr/firefox-${FIREFOX_VERSION}.tar.bz2 &&\
    tar xjf firefox-*.tar.bz2 &&\
    mv firefox /opt/firefox-${FIREFOX_VERSION}/ &&\
    rm firefox-*.tar.bz2 &&\
    ln -s /opt/firefox-${FIREFOX_VERSION}/firefox /usr/bin/firefox

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