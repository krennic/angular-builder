FROM node:7.3

MAINTAINER krennic

# Install npm and curl
RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    npm \
    && rm -rf /var/lib/apt/lists/*

#RUN npm install npm@latest -g && npm cache clean && rm -rf ~/.npm
RUN npm install -g @angular/cli@v1.0.0-rc.1 && npm cache clean && rm -rf ~/.npm

# install firefox for karma testing
RUN echo 'deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu trusty main' > /etc/apt/sources.list.d//mozillateam-firefox-next-trusty.list &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE49EC21 &&\
    apt-get update &&\
    apt-get install -y firefox xvfb python-pip &&\
    rm -rf /var/lib/apt/lists/* &&\
    pip install selenium

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
