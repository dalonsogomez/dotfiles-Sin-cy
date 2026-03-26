#!/bin/bash

git_item=(
  icon=""
  icon.color=$GREY
  label="0"
  label.max_chars=6
  background.drawing=off
  update_freq=60
  updates=on
  click_script="$PLUGIN_DIR/open_dotfiles.sh"
  script="$PLUGIN_DIR/git_status.sh"
)

sketchybar --add item git right \
           --set git "${git_item[@]}"
