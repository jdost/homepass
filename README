# Homepass

This is a collection of scripts to allow for various functionality in creating
your own homepass server (homepass is a way to emulate a Nintendo Zone AP from
home).

## Usage

Calling `./bin/nzone.sh start` will do the initial setup of the services and
calling with the `stop` argument will tear down all the services.  Calling it
without any arguments will (if running) find the next MAC in the set and switch
to that (you can set this to be called via a cronjob).

## Notes

A few things you need to figure out and correct:

* The `driver` value in the `hostapd.conf` file should be whatever the
  wireless driver for your card is.
* If you are using a card with the `RTL8188CUS` chipset, it doesn't support
  the MAC spoofing and requires using a custom compiled `hostapd` package that
  includes the correct driver
* Change the `APDEV` and `WANDEV` to be the interfaces for the two sides of
  your connectivity (`APDEV` is the device acting as your AP broadcaster and
  `WANDEV` is the device that is connected to the WAN/internet)
* You need to populate your mac list yourself, if you know of a web service
  to download the lists from, see the `update-macs` section

## `update-macs`

If you know of a website with lists of the macs, you can use the included
script to download/update these lists.  This requires setting the `URL` value
in the config and adding a `.sets` file in the macs folder with the name of
each set.

(Note: I know this README needs some more explanation, this is just an inital
pass while I put this stuff on github).
