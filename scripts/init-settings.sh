#!/bin/bash

SCRIPT_DIR="${BASH_SOURCE[0]}"
if [ ! -z $SCRIPT_DIR ]; then
  pushd . > /dev/null
  if [ -h "${SCRIPT_DIR}" ]; then
    while ([ -h "${SCRIPT_DIR}" ]); do
      cd "$(dirname "$SCRIPT_DIR")"
      SCRIPT_DIR=$(readlink "${SCRIPT_DIR}")
    done
  fi
  cd "$(dirname ${SCRIPT_DIR})" > /dev/null
  SCRIPT_DIR=$(pwd);
  popd  > /dev/null
fi
SCRIPT_DIR=${SCRIPT_DIR:="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"}

. $SCRIPT_DIR/init-feed-settings.sh

if [ -d "$GITHUB_WORKSPACE/.env" ]; then
  if [ -f "$GITHUB_WORKSPACE/.env/authorized_keys" ]; then
    mkdir -p $OPENWRTROOT/files/etc/dropbear
    cp "$GITHUB_WORKSPACE/.env/authorized_keys" $OPENWRTROOT/files/etc/dropbear/
    chmod g-w $OPENWRTROOT/files/etc/dropbear/authorized_keys
  fi
fi
