#!/usr/bin/env bash

herbstclient rule prepend tag=$1 pid="${$}" once maxage=120

shift

exec "$@"
