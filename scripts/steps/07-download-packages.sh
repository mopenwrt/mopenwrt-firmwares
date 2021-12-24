#!/bin/bash

if [ $SKIP_DOWNLOAD_PACKAGES != "true" ]; then
  cd $OPENWRTROOT
  make download -j$NUMCORES
  # find dl -size -1024c -exec ls -l {} \;
  # find dl -size -1024c -exec rm -f {} \;
fi
