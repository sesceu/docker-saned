FROM debian:stable
MAINTAINER Jan De Luyck <jan@kcore.org>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN apt-get install -y \
    sane \
    sane-utils \
    libsane-extras \
    libsane-hpaio \
    dbus \
    avahi-utils \
    runit \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser saned scanner \
    && adduser saned lp \
    && chown saned:lp /etc/sane.d/saned.conf /etc/sane.d/dll.conf

COPY services/ /etc/sv/
COPY runit_startup.sh /

RUN ln -s /etc/sv/dbus /etc/service/
RUN ln -s /etc/sv/saned /etc/service/

EXPOSE 6566 10000 10001

CMD ["/runit_startup.sh"]

# Make sure that the device node e.g. /dev/usb/00x/ have group id 7 (lp) and group read access.
# Environment variable:
#   SANED_ACL      - [required] IP ranges or hosts that are allowed access to the daemon.
#   SANED_DLL      - [optional] Overwrite /etc/sane.d/dll.conf with these values for faster response of saned.
#   SANED_LOGLEVEL - [optional] Set a higher log level for sane. Default = 2, up to 128
#
# docker run -v /dev/bus/usb:/dev/bus/usb --privileged -e SANED_ACL="192.168.0.0/24\n10.0.0.0/8" jdeluyck/docker-saned
