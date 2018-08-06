#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

DAEMON=/usr/local/bin/ungit

stop() {
    echo "Received SIGINT or SIGTERM. Shutting down $DAEMON"
    pid=$(cat /var/run/$DAEMON/$DAEMON.pid)
    kill -SIGTERM "${pid}"
    wait "${pid}"
    echo "Done."
}

git config --global user.email ${GIT_USER_EMAIL:-"unknown-dev@ipburger.com"}
git config --global user.name ${GIT_USER_NAME:-"Unkown IPBurger Dev"}

echo "Running $@"
if [ "$(basename $1)" == "$DAEMON" ]; then
    trap stop SIGINT SIGTERM
    $@ &
    pid="$!"
    mkdir -p /var/run/$DAEMON && echo "${pid}" > /var/run/$DAEMON/$DAEMON.pid
    wait "${pid}" && exit $?
else
    exec "$@"
fi
