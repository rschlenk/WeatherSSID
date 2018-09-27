#!/bin/sh

###############
# Definitions #
###############

# enable syslog logging
LOGGER=1

# default SSID
DEFAULTSSID="Temp. data not available"


######################
# Configure new SSID #
######################

# for phy0 only, should be sufficient also for dualband devices 
HOSTAPD=/var/run/hostapd-phy0.conf
WEATHERSSIDCONF=wireless.client_radio0_weather

if [ "$1" == "start" ]; then
  # if router has no weatherssid configuration yet create it via UCI and enable it
  # 'uci commit' saves new config to flash, 'wifi' rewrites configuration (for hostapd)
  if [ ! $(uci get -q $WEATHERSSIDCONF) ]; then
    uci set $WEATHERSSIDCONF=wifi-iface
    uci set $WEATHERSSIDCONF.device="radio0"
    uci set $WEATHERSSIDCONF.network="mesh"  # must match network of w2ap
    uci set $WEATHERSSIDCONF.ifname="weather"
    uci set $WEATHERSSIDCONF.mode="ap"
    uci set $WEATHERSSIDCONF.ssid="${DEFAULTSSID}"
    uci set $WEATHERSSIDCONF.disabled="0"
    uci commit $WEATHERSSIDCONF
    wifi
    # write info to syslog
    if [ $LOGGER != 0 ]; then
      logger -s -t "WeatherSSID" -p 6 "SSID \"$DEFAULTSSID\" added and enabled"
    fi
  # enable SSID
  elif [ "$(uci get -q $WEATHERSSIDCONF.disabled)" == "1" ]; then
    uci set $WEATHERSSIDCONF.disabled="0"
    uci commit $WEATHERSSIDCONF
    wifi
    # write info to syslog
    if [ $LOGGER != 0 ]; then
      logger -s -t "WeatherSSID" -p 6 "SSID \"$DEFAULTSSID\" enabled"
    fi
  fi 
elif [ "$1" == "stop" ]; then
  # disable SSID
  if [ "$(uci get -q $WEATHERSSIDCONF)" ]; then
    uci set $WEATHERSSIDCONF.disabled="1"
    uci commit $WEATHERSSIDCONF
    wifi
    # write info to syslog
    if [ $LOGGER != 0 ]; then
      logger -s -t "WeatherSSID" -p 6 "SSID \"$DEFAULTSSID\" disabled"
    fi
  fi
else
  echo "WeatherSSID usage: $0 [start|stop]" >&2
  exit 1
fi

