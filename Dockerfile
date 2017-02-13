FROM ubuntu:16.04
MAINTAINER Sebastian Schneider <mail@sesc.eu>

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN apt-get update && apt-get install -y \
    sane \
    sane-utils \
    libsane-extras \
    libsane-hpaio \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser saned scanner \
    && adduser saned lp

USER saned
