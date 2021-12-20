#!/bin/bash

cd $OPENWRTROOT
. ${GITHUB_WORKSPACE}/scripts/init-feed-settings.sh
make package/install -j$NUMCORES || make package/install -j1 V=s
make target/install -j$NUMCORES || make target/install -j1 V=s
make checksum
echo "::set-output name=GENERATE_STATUS::success"
