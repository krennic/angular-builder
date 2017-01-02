FROM node:7.3

MAINTAINER krennic

RUN apt-get update && \
    apt-get install -y \
    curl \
    npm &&\
    npm install npm@latest &&\
    npm install angular-cli@latest

WORKDIR /workspace
