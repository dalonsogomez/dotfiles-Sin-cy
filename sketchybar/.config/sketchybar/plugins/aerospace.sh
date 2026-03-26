#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

ITEM_WS="$1"
[ -z "$ITEM_WS" ] && ITEM_WS="${NAME#space.}"

CURRENT_WS="$FOCUSED_WORKSPACE"
[ -z "$CURRENT_WS" ] && CURRENT_WS="$INFO"

if [ -z "$CURRENT_WS" ]; then
  if command -v aerospace >/dev/null 2>&1; then
    CURRENT_WS="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"
  elif [ -x /opt/homebrew/bin/aerospace ]; then
    CURRENT_WS="$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null | head -n1)"
  fi
fi

if [ "$ITEM_WS" = "$CURRENT_WS" ]; then
  sketchybar --animate tanh 14 --set "$NAME" \
    background.drawing=on \
    background.color="$WS_ACTIVE_BG" \
    background.border_color="$WS_ACTIVE_BORDER" \
    icon.color="$WS_ACTIVE_TEXT"
else
  sketchybar --animate tanh 14 --set "$NAME" \
    background.drawing=on \
    background.color="$WS_INACTIVE_BG" \
    background.border_color="$MUTED_BORDER" \
    icon.color="$WS_INACTIVE_TEXT"
fi
