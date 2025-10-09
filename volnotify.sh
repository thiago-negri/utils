#!/usr/bin/env bash
#
# This is piped into dzen to show volume.
#
# See dotfiles/.config/herbstluftwm/panel.sh
#
vol() {
    local v
    v=$(wpctl get-volume @DEFAULT_SINK@)
    if [[ "$v" =~ "[MUTED]" ]]; then
        echo "MUTED"
    else
        v=$(echo "$v" | cut -d' ' -f2)
        echo "$v * 100" | bc | cut -d. -f1
    fi
}

emit() {
    local v
    v=$(vol)
    [ -z "$v" ] || printf "vol\t$v\n"
}

# The pipe spawn sub processes (pactl + while loop).
# Killing the while loop (using $! pid) will not kill the pactl.
# Easiest way I found to avoid leaking processes if I reload my panel is to 'wait' and kill jobs on SIGINT|SIGTERM
trap 'kill $(jobs -p)' INT TERM

emit
pactl subscribe | while read -r line; do
    if [[ "$line" =~ 'change' ]]; then
        emit
    fi
done &

wait
