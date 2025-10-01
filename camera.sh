#!/usr/bin/env bash

source "$HOME/projects/utils/secrets"

exec vlc "rtsp://$CAMERA_USER:$CAMERA_PASSWORD@$CAMERA_ADDR/cam/realmonitor?channel=1&subtype=0"
