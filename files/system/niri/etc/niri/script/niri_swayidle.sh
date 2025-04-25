#!/usr/bin/env bash
BT="$blackout_timeout"
BT=${BT:-300}
LT="$lock_timeout"
LT=${LT:-30}
ST="$screen_timeout"
ST=${ST:-30}

screenOn () {
    niri msg --json outputs | jq -r '.[].name' | xargs -I{} niri msg output {} on
}
screenOff () {
    niri msg --json outputs | jq -r '.[].name' | xargs -I{} niri msg output {} off
}
export -f screenOn screenOff

swayidle -w \
    timeout $BT "brightnessctl -sq set 10%" \
        resume "brightnessctl -r" \
    timeout $((BT + LT)) "swaylock -f" \
    timeout $((BT + LT + ST)) "screenOff" \
        resume "screenOn"  \
    timeout $ST "pgrep -xu "$USER" swaylock >/dev/null && screenOff" \
        resume "pgrep -xu "$USER" swaylock >/dev/null && screenOn"  \
    before-sleep "swaylock -f" \
    lock "swaylock -f" \
    unlock "pkill -xu "$USER" -SIGUSR1 swaylock"
