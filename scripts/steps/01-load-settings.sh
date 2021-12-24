#!/bin/bash

shopt -s globstar

NUMCORES=$(nproc)
(($NUMCORES <= 0)) && NUMCORES=1


cp "${GITHUB_WORKSPACE}/devices/common/settings.ini" $GITHUB_ENV
source "${GITHUB_WORKSPACE}/devices/common/settings.ini"
if [ -f "${GITHUB_WORKSPACE}/devices/$MYTARGET/settings.ini" ]; then
  echo Merge $MYTARGET/settings.ini to $GITHUB_ENV
  source "${GITHUB_WORKSPACE}/devices/$MYTARGET/settings.ini"
  /usr/bin/crudini --merge $GITHUB_ENV < "${GITHUB_WORKSPACE}/devices/$MYTARGET/settings.ini"
fi

echo "OPENWRTROOT=${GITHUB_WORKSPACE}/openwrt" >> $GITHUB_ENV
echo "MYTARGET=${MYTARGET}" >> $GITHUB_ENV
echo "NUMCORES=${NUMCORES}" >> $GITHUB_ENV
chmod +x ${GITHUB_WORKSPACE}/scripts/**/*.sh

