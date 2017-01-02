FROM node:7.3

MAINTAINER krennic

RUN apt-get update && \
    apt-get install -y \
    curl \
    npm

RUN npm install npm@latest -g &&\
    npm rm
RUN npm install angular-cli -g

WORKDIR /workspace
