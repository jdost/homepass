#!/bin/bash

BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
echo $BASEDIR
exit 0
CONFIG=$BASEDIR/conf/homepass

source $CONFIG

STATEFILE=$STATEDIR/nzone.state
DEFAULTSTATEFILE=$BASEDIR/conf/default.state
HOMEPASSLIB=$BASEDIR/src/library.sh

if [ ! -d $STATEDIR ]; then
  mkdir -p $STATEDIR
fi

if [ ! -f $STATEFILE ]; then
  cp $DEFAULTSTATEFILE $STATEFILE
fi

source $STATEFILE
source $HOMEPASSLIB

get_mac

start() {
  update_card
  start_dnsmasq
  sysctl -w net.ipv4.ip_forward=1
  update_iptables
  start_hostapd
}

stop() {
  update_card
  stop_dnsmasq
  stop_hostapd
  update_iptables
}

update() {
  stop_hostapd
  rfkill unblock $APDEV
  next_mac
  update_card
  start_hostapd
}

case "$1" in
  start)
    if [ ! "$STATE" == "RUNNING" ]; then
      STATE="RUNNING"
      start
    fi
    ;;
  stop)
    if [ "$STATE" == "RUNNING" ]; then
      STATE="STOPPED"
      stop
    fi
    ;;
  restart)
    [ "$STATE" == "RUNNING" ] && stop
    [ "$STATE" != "RUNNING" ] && start
    ;;
  toggle)
    if [ "$STATE" == "RUNNING" ]; then
      STATE="STOPPED"
      stop
    else
      STATE="RUNNING"
      start
    fi
    ;;
  set)
    SET=$2
    if [ -f $MACLOCATION/$SET ]; then
      MACSET=$SET
    else
      echo "The MAC set $SET does not exist, please update it."
      exit 1
    fi
    ;;
  generate)
    next_mac
    update_hostapd
    ;;
  *)
    update
    ;;
esac

save_config
