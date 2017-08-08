#!/usr/bin/env bash

START_DELAY=5

MON_MAIN=LVDS1
MON_EXT=DP1

enable_monitor_ext() {
    xrandr --output "${MON_EXT}" --auto --above "${MON_MAIN}"
}
disable_monitor_ext() {
    xrandr --output "${MON_EXT}" --off
}

# ---

renice +19 $$ >/dev/null

sleep "${START_DELAY}"

OLD_DUAL="dummy"

while [ 1 ]; do
    inotifywait -q -e close /sys/class/drm/card0-DP-2/status >/dev/null

    DUAL=$(cat /sys/class/drm/card0-DP-2/status)

    if [ "$OLD_DUAL" != "$DUAL" ]; then
        if [ "$DUAL" == "connected" ]; then
            echo 'Dual monitor setup'
            xrandr --output DP1 --auto --above LVDS1
        else
            echo 'Single monitor setup'
            xrandr --auto
        fi

        OLD_DUAL="$DUAL"
    fi
done

