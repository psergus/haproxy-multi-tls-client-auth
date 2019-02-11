#!/bin/sh
set -e
set -o errexit
set -o nounset

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
  set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
  # if the user wants "haproxy", let's use "haproxy-systemd-wrapper" instead so we can have proper reloadability implemented by upstream
  shift # "haproxy"
  set -- "$(which haproxy-systemd-wrapper)" -d -p /run/haproxy.pid "$@"
fi

echo Starting "$@"
exec "$@"
