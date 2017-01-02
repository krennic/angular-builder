FROM node:7.3

MAINTAINER krennic

RUN apt-get update && \
    apt-get install -y \
    curl \
    npm &&\
    npm install npm@latest -g &&\
    npm install angular-cli@latest -g &&\
    npm cache clean

WORKDIR /workspace
