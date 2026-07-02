#!/usr/bin/env bash

herbstclient rule prepend tag=$1 title="Steam" once maxage=120
herbstclient rule prepend tag=$1 title="Sign in to Steam" once maxage=120

exec steam
