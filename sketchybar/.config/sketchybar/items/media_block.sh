#!/bin/bash

source "$ITEM_DIR/battery.sh"
source "$ITEM_DIR/wifi.sh"
source "$ITEM_DIR/volume.sh"
source "$ITEM_DIR/mic.sh"

sketchybar --add bracket media_block battery wifi volume_icon mic \
           --set media_block \
             background.color="$ITEM_BG_COLOR" \
             background.corner_radius=5 \
             background.border_color="$WIDGET_BORDER_BATTERY" \
             background.border_width=1 \
             background.padding_left=0 \
             background.padding_right=0 \
             background.height=20
