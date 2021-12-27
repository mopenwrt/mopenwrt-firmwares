#!/bin/bash
#=================================================
shopt -s extglob

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

/bin/bash "${SCRIPT_DIR}/customfeeds.sh"

/bin/bash "${SCRIPT_DIR}/add-packages.sh"

if [[  $UPDATE_REPO == "true" || ! -f "$GITHUB_WORKSPACE/devices/common/diy/v2ray-rules-dat.tgz" ]]; then
  mkdir -p /tmp/usr/share/v2ray
  pushd /tmp/usr/share/v2ray
  wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
  wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
  popd
  tar czf "$GITHUB_WORKSPACE/devices/common/diy/v2ray-rules-dat.tgz" -C /tmp/ usr
fi
