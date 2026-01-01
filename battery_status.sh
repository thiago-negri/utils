#!/usr/bin/env bash

ac=$(upower -i /org/freedesktop/UPower/devices/line_power_AC | grep 'online' | grep -q 'yes' || echo '!! AC OFF !! ')
bat=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -f2 -d':' | xargs)

echo "$ac$bat"
