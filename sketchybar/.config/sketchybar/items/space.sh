#!/bin/bash

SPACE_IDS=("1" "2" "3" "4" "8" "9" "B" "F" "M" "N" "T")
SPACE_ITEMS=()

for id in "${SPACE_IDS[@]}"; do
  case "$id" in
    B) icon="${WS_BROWSER:-B}" ;;
    F) icon="${WS_FINDER:-F}" ;;
    M) icon="${WS_MUSIC:-M}" ;;
    N) icon="${WS_NOTES:-N}" ;;
    T) icon="${WS_TERMINAL:-T}" ;;
    *) icon="$id" ;;
  esac

  border_var="WS_BORDER_${id}"
  border_color="${!border_var:-$MUTED_BORDER}"

  space_item=(
    icon="$icon"
    icon.padding_left=6
    icon.padding_right=6
    icon.y_offset=1
    label.drawing=off
    background.color="$WS_INACTIVE_BG"
    background.border_color="$border_color"
    background.border_width=1
    background.corner_radius=4
    background.padding_left=2
    background.padding_right=2
    background.height=18
    icon.font="$FONT:Regular:12.0"
    icon.color="$WS_INACTIVE_TEXT"
    drawing=on
    script="$PLUGIN_DIR/aerospace.sh $id"
    click_script="$PLUGIN_DIR/close_popups.sh; aerospace workspace $id"
  )

  sketchybar --add item space.$id left \
             --set space.$id "${space_item[@]}" \
             --subscribe space.$id aerospace_workspace_change

  SPACE_ITEMS+=("space.$id")
done

sketchybar --add bracket workspaces "${SPACE_ITEMS[@]}" \
           --set workspaces background.drawing=off
