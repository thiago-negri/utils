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

# The pipes spawns 3 sub processes (pactl, grep, while loop).
# Killing the while loop (using $! pid) will not kill the grep, nor the pactl.
# Easiest way I found to avoid leaking processes if I reload my panel is to 'wait' and kill jobs on SIGINT|SIGTERM
trap 'kill $(jobs -p)' INT TERM

printf "vol\t$(vol)\n"
pactl subscribe | grep --line-buffered 'change' | while read -r _; do
    printf "vol\t$(vol)\n"
done &

wait
