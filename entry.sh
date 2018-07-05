#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

DAEMON=/usr/bin/ungit

stop() {
    echo "Received SIGINT or SIGTERM. Shutting down $DAEMON"
    pid=$(cat /var/run/$DAEMON/$DAEMON.pid)
    kill -SIGTERM "${pid}"
    wait "${pid}"
    echo "Done."
}

if ls /run/secrets/*_private_key 1> /dev/null 2>&1; then
  cat /run/secrets/${USERNAME}_private_key > /root/${USERNAME}_private_key
  chmod 400 /root/${USERNAME}_private_key

  git config --global core.sshCommand "ssh -i /root/${USERNAME}_private_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
fi

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
