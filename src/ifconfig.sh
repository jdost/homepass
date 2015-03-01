#!/bin/bash

AP_IP="192.168.23.1"

update_card() {
  if [ ! -z "$1" ]; then
    ifconfig $APDEV down hw ether $1 up
  elif [ "$STATE" == "RUNNING" ]; then
    ifconfig $APDEV hw ether $MACADDRESS
    ifconfig $APDEV $AP_IP up
  elif [ "$STATE" == "STOPPED" ]; then
    ifconfig $APDEV down
  fi
}
