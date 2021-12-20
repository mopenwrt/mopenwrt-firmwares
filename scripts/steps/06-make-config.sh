#!/bin/bash

cd $OPENWRTROOT

cp -f devices/common/$CONFIG_FILE .config
if [ -f "devices/${MYTARGET}/$CONFIG_FILE" ]; then
  echo >> .config
  cat devices/${MYTARGET}/$CONFIG_FILE >> .config
fi

if [ "$KMODS_IN_FIRMWARE" = 'true' ]; then
  echo "enable KMODS_IN_FIRMWARE"
  echo "CONFIG_ALL_NONSHARED=y" >> .config
fi

make defconfig

[[ -f "devices/common/after_defconf.sh" ]] && /bin/bash "devices/common/after_defconf.sh"
[[ -f "devices/${MYTARGET}/after_defconf.sh" ]] && /bin/bash "devices/${MYTARGET}/after_defconf.sh"
