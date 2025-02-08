#!/bin/sh /etc/rc.common

START=99
STOP=15

start() {
    /usr/bin/custom_filter
    service dnsmasq restart
    service uhttpd restart
}

stop() {
    rm /etc/dnsmasq.d/custom_block.conf
    service dnsmasq restart
}