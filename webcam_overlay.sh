#!/bin/sh

# Settings
CAM_WIDTH=320
CAM_HEIGHT=240
DEVICE=/dev/video0

# Make sure 'mplayer' is available
if ! type "mplayer" > /dev/null; then
  echo "You need to install 'mplayer' first."
  exit 1
fi

# Get current screen width and height
SCREEN_WIDTH=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3}')
SCREEN_HEIGHT=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $4}')

# Calculate horizontal and vertical offset to position the webcam overlay at
# bottom right corner
HORIZONTAL_OFFSET=$(expr $SCREEN_WIDTH - $CAM_WIDTH)
VERTICAL_OFFSET=$(expr $SCREEN_HEIGHT - $CAM_HEIGHT) 

mplayer -ontop -noborder \
  -geometry ${CAM_WIDTH}x${CAM_HEIGHT}+${HORIZONTAL_OFFSET}+${VERTICAL_OFFSET} \
  -tv driver=v4l2:width=${CAM_WIDTH}:height=${CAM_HEIGHT}:device=${DEVICE} tv://

