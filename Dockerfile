FROM node:7.3

MAINTAINER krennic

RUN apt-get update && apt-get install -y --no-install-recommends\
    curl \
    npm \
    && rm -rf /var/lib/apt/lists/*

#RUN npm install npm@latest -g && npm cache clean && rm -rf ~/.npm

RUN npm install -g angular-cli@v1.0.0-beta.24 && npm cache clean && rm -rf ~/.npm

RUN npm install node-sass@3.13.1 && npm cache clean && rm -rf ~/.npm

WORKDIR /workspace
