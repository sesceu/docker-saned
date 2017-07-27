#!/bin/sh

export > /etc/envvars

exec /usr/sbin/runit
