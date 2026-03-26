#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/close_popups.sh" >/dev/null 2>&1 || true

osascript <<'APPLESCRIPT' >/dev/null 2>&1
if application "Spotify" is running then
  tell application "Spotify" to playpause
else if application "Music" is running then
  tell application "Music" to playpause
else
  tell application "Spotify" to activate
end if
APPLESCRIPT
