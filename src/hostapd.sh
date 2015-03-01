#!/bin/bash

HOSTAPDPID=$STATEDIR/hostapd.pid
HOSTAPD_HOMEPASSCONF=$BASEDIR/conf/hostapd.conf
HOSTAPD_NORMALCONF=$BASEDIR/conf/hostapd.normal.conf

start_hostapd() {
  if [ -f $HOSTAPDPID ]; then
    echo "hostapd already running"
  else
    update_hostapd
    hostapd -B -P $HOSTAPDPID $HOSTAPD_HOMEPASSCONF
  fi
}

update_hostapd() {
  get_mac
  sed -ri "s/^(bssid=).*?/\1$MACADDRESS/;s/^(ssid=).*?/\1$SSID/" $HOSTAPD_HOMEPASSCONF
}

stop_hostapd() {
  if [ -f $HOSTAPDPID ]; then
    kill $(cat $HOSTAPDPID)
    rm -f $HOSTAPDPID
  fi
}

get_mac() {
  MACADDRESS=$(grep "bssid" $HOSTAPD_HOMEPASSCONF | cut -d'=' -f2)
  SSID=$(grep "^ssid" $HOSTAPD_HOMEPASSCONF | cut -d'=' -f2)
}
