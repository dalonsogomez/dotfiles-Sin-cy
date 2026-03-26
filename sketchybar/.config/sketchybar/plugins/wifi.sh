#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

get_wifi_device() {
  if ifconfig en0 >/dev/null 2>&1; then
    printf "en0"
    return
  fi
  networksetup -listallhardwareports 2>/dev/null | awk '
    BEGIN { IGNORECASE = 1 }
    /^Hardware Port: (Wi-Fi|AirPort)$/ { want = 1; next }
    want && /^Device: / { print $2; exit }
  '
}

WIFI_DEV="$(get_wifi_device)"
STATE=""
IP_ADDR=""

if [ -n "$WIFI_DEV" ]; then
  STATE="$(ifconfig "$WIFI_DEV" 2>/dev/null | awk '/status:/{print $2; exit}')"
  IP_ADDR="$(ipconfig getifaddr "$WIFI_DEV" 2>/dev/null)"
fi

if [ -n "$WIFI_DEV" ] && [ "$STATE" = "active" ] && [ -n "$IP_ADDR" ]; then
  sketchybar --set "$NAME" icon="$WIFI_CONNECTED" icon.color=0xff58d1fc
else
  sketchybar --set "$NAME" icon="$WIFI_DISCONNECTED" icon.color="$RED"
fi
