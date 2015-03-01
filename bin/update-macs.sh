#!/bin/sh

BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
source $BASEDIR/conf/homepass

MAC_LOCATION=$BASEDIR/macs
MAC_SET=$(cat $MAC_LOCATION/.sets)

for SET in $MAC_SET; do
  wget -O $MAC_LOCATION/$SET $MAC_URL?$SET
done
