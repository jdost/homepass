#!/bin/bash

DNSMASQPID=$STATEDIR/dnsmasq.pid
DNSMASQCONF=/opt/homepass/dnsmasq.conf

DNSMASQRANGE="192.168.23.50,192.168.23.150,255.255.255.0,12h"
DNSPORT=53

start_dnsmasq() {
  if [ -f $DNSMASQPID ]; then
    echo "dnsmasq already running"
  else
    #dnsmasq -i $APDEV -x $DNSMASQPID -F $DNSMASQRANGE -p $DNSPORT -C $DNSMASQCONF
    dnsmasq -i $APDEV -x $DNSMASQPID -F $DNSMASQRANGE -p $DNSPORT
  fi
}

stop_dnsmasq() {
  if [ -f $DNSMASQPID ]; then
    kill $(cat $DNSMASQPID)
    rm -f $DNSMASQPID
  fi
}
