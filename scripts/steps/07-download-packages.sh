#!/bin/bash

cd $OPENWRTROOT
make download -j$(($(nproc)+1))
# find dl -size -1024c -exec ls -l {} \;
# find dl -size -1024c -exec rm -f {} \;
