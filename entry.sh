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

source /git_credentials || true
GIT_USER_EMAIL_VAR="${USERNAME}_GIT_USER_EMAIL"
git config --global user.email ${!GIT_USER_EMAIL_VAR:-"unknown-dev@ipburger.com"}

GIT_USER_NAME_VAR="${USERNAME}_GIT_USER_NAME"
git config --global user.name ${!GIT_USER_NAME_VAR:-"Unknown IPBurger Dev"}

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
