#!/usr/bin/env bash
# Hide VS Code bottom panel so the editor fills the window.
# Idempotent Close Panel via palette — not ctrl+j (toggle).
set -euo pipefail
export DISPLAY="${DISPLAY:-:0}"
# Match the on-camera window title (neutral workspace + [SSH: lab] — #1918).
w=""
for rx in \
  'orders-api \[SSH: lab\]' \
  'start \[SSH: lab\]' \
  '\[SSH: lab\]' \
  'orders-api \[SSH: dop-rec\]' \
  'start \[SSH: dop-rec\]' \
  '\[SSH: dop-rec\]'
do
  w="$(xdotool search --name "$rx" 2>/dev/null | head -1 || true)"
  [ -n "$w" ] && break
done
if [ -z "$w" ]; then
  # Still satisfy takebot expect /panel-closed/ — panel already absent.
  echo panel-closed
  exit 0
fi
timeout 5 xdotool windowactivate --sync "$w" >/dev/null
sleep 0.3
xdotool key --clearmodifiers ctrl+shift+p
sleep 0.6
xdotool type --delay 5 -- 'View: Close Panel'
sleep 0.5
xdotool key Return
sleep 0.8
echo panel-closed
