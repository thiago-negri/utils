#!/usr/bin/env bash
#
# Set framebuffer to a 16:9 resolution so it shows correctly on my external
# monitor.  The native resolution of my laptop monitor is 16:10 so the bottom
# part of the framebuffer is cutoff on the external monitor otherwise.
#
# On Void, I add that line to rc.local so it's run just before the login
# starts.
#
fbset -a -g 2560 1440 2560 1440 32
