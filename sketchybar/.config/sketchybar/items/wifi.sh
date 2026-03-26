#!/bin/bash

wifi=(
  script="$PLUGIN_DIR/wifi.sh"
  icon=$WIFI_CONNECTED
  label.drawing=off
  background.drawing=off
  icon.font="$FONT:Regular:14.0"
  icon.align=center
  icon.padding_left=8
  icon.padding_right=8
  padding_left=0
  padding_right=0
  icon.color=0xff58d1fc
  update_freq=30
  updates=on
  click_script="$PLUGIN_DIR/open_network_settings.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}"
