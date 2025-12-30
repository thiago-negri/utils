#!/bin/sh

xrandr \
  --output eDP-1 --mode 1680x1050 --pos 0x0 \
  --output DP-2 --mode 2560x1440 --pos 1680x160 --right-of eDP-1 --primary

# xrandr \
#   --output eDP-1-1 --mode 1680x1050 --pos 0x0 \
#   --output DP-1-2 --mode 2560x1440 --pos 1680x160 --right-of eDP-1-1 --primary
