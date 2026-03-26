#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

trim() {
  local s="$1" max="$2"
  if [ "${#s}" -gt "$max" ]; then
    printf "%s…" "${s:0:$((max-1))}"
  else
    printf "%s" "$s"
  fi
}

get_spotify() {
  osascript <<'APPLESCRIPT' 2>/dev/null
if application "Spotify" is running then
  tell application "Spotify"
    if player state is playing then
      return "spotify|||" & name of current track & "|||" & artist of current track
    end if
  end tell
end if
return ""
APPLESCRIPT
}

get_music() {
  osascript <<'APPLESCRIPT' 2>/dev/null
if application "Music" is running then
  tell application "Music"
    if player state is playing then
      return "music|||" & name of current track & "|||" & artist of current track
    end if
  end tell
end if
return ""
APPLESCRIPT
}

DATA="$(get_spotify)"
[ -z "$DATA" ] && DATA="$(get_music)"

if [ -z "$DATA" ]; then
  sketchybar --set "$NAME" icon="" icon.color="$GREY" label="" drawing=off
  exit 0
fi

SRC="${DATA%%|||*}"
rest="${DATA#*|||}"
TRACK="${rest%%|||*}"
ARTIST="${rest#*|||}"

TEXT="$(trim "$TRACK" 18)"
[ -n "$ARTIST" ] && TEXT="$TEXT · $(trim "$ARTIST" 12)"

if [ "$SRC" = "spotify" ]; then
  ICON=""
  ICON_COLOR=0xff1db954
else
  ICON=""
  ICON_COLOR="$WHITE"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$ICON_COLOR" label="$TEXT" drawing=on
