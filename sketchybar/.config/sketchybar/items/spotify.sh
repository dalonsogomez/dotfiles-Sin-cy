#!/bin/bash

spotify=(
  icon=""
  icon.color=$GREY
  label.max_chars=30
  label.drawing=on
  background.drawing=off
  update_freq=20
  updates=on
  click_script="$PLUGIN_DIR/spotify_click.sh"
  script="$PLUGIN_DIR/spotify.sh"
)

sketchybar --add item spotify right \
           --set spotify "${spotify[@]}" \
           --subscribe spotify spotify_playback_change front_app_switched
