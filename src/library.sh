#!/bin/sh

MACLOCATION=$BASEDIR/macs
MACSET=${MACSET:-BASE16}

source $BASEDIR/src/dnsmasq.sh
source $BASEDIR/src/hostapd.sh
source $BASEDIR/src/ifconfig.sh

update_iptables() {
  iptables -t nat -A POSTROUTING -o $WANDEV -j MASQUERADE
  iptables -A FORWARD -i $APDEV -j ACCEPT
}

next_mac() {
  get_mac

  MACFILE=$MACLOCATION/$MACSET
  LINENUMBER=$(grep -nr -m 1 $CURRENTMAC $MACFILE | cut -d':' -f1)

  if [ -z "$LINENUMBER" ]; then
    LINENUMBER="1"
  elif [ $LINENUMBER == $(wc -l $MACFILE | cut -d' ' -f1) ]; then
    LINENUMBER="1"
  else
    LINENUMBER=$(($LINENUMBER+1))
  fi

  MACINFO=$(sed -n $LINENUMBER"p" $MACFILE)
  if [[ $MACINFO == *","* ]]; then
    MACADDRESS=$(echo $MACINFO | cut -d',' -f1)
    SSID=$(echo $MACINFO | cut -d',' -f2)
  else
    MACADDRESS=$MACINFO
    SSID=$DEFAULT_SSID
  fi
}

save_config() {
  echo "STATE=$STATE
MACSET=$MACSET" > $STATEFILE
}
