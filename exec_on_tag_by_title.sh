#!/usr/bin/env bash

herbstclient rule prepend tag=$1 title="$2" once maxage=120

shift
shift

exec "$@"
