#!/usr/bin/env bash
#
# This is piped into dzen to show volume.
#
# See dotfiles/.config/herbstluftwm/panel.sh
#
vol() {
    local v
    v=$(pactl get-sink-mute @DEFAULT_SINK@)
    if [ "$v" = "Mute: yes" ]; then
        echo "MUTED"
    else
        # v=$(pactl get-sink-volume @DEFAULT_SINK@ | cut -d' ' -f6)
        v=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n1 | cut -d'/' -f2 | tr -d '[:blank:]')
        echo "${v%\%}"
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
    case "$line" in
        "Event 'change' on sink "*)
            emit
            ;;
    esac
done &

wait
