#!/usr/bin/env bash

herbstclient rule prepend tag=$1 pid="${$}" once maxage=10

shift

exec "$@"
