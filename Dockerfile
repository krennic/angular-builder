FROM node:7.3

MAINTAINER krennic

RUN apt-get update && \
    apt-get install -y \
    curl \
    npm

RUN npm install -g npm@latest &&\
    npm install -g angular-cli

WORKDIR /workspace
