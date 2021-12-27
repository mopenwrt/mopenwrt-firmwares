#!/bin/bash

cd $OPENWRTROOT

cp -f devices/common/$CONFIG_FILE .config
if [ -f "devices/${MYTARGET}/$CONFIG_FILE" ]; then
  echo >> .config
  cat devices/${MYTARGET}/$CONFIG_FILE >> .config
fi

[[ -f "devices/common/add_conf.sh" ]] && /bin/bash "devices/common/add_conf.sh"
[[ -f "devices/${MYTARGET}/add_conf.sh" ]] && /bin/bash "devices/${MYTARGET}/add_conf.sh"

make defconfig

[[ -f "devices/common/after_defconf.sh" ]] && /bin/bash "devices/common/after_defconf.sh"
[[ -f "devices/${MYTARGET}/after_defconf.sh" ]] && /bin/bash "devices/${MYTARGET}/after_defconf.sh"
[[ -f "$GITHUB_WORKSPACE/.env/${MYTARGET}/after_defconf.sh" ]] && /bin/bash "$GITHUB_WORKSPACE/.env/${MYTARGET}/after_defconf.sh"
