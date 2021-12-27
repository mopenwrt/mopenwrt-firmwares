#!/bin/bash

shopt -s globstar
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

# cp -rf devices/common/. openwrt/
# cp -rf devices/${MYTARGET}/. openwrt/
cp -rf "$GITHUB_WORKSPACE/devices" "$OPENWRTROOT/"

chmod +x "$OPENWRTROOT/devices/${MYTARGET}/*.sh" || true
chmod +x "$OPENWRTROOT/devices/common/*.sh"  || true

cd "$OPENWRTROOT"

[ -f "devices/common/before_defconf.sh" ] && /bin/bash devices/common/before_defconf.sh
[ -f "devices/${MYTARGET}/before_defconf.sh" ] && /bin/bash "devices/${MYTARGET}/before_defconf.sh"
[ -f "$GITHUB_WORKSPACE/.env/before_defconf.sh" ] && /bin/bash "$GITHUB_WORKSPACE/.env/before_defconf.sh"
[ -f "$GITHUB_WORKSPACE/.env/${MYTARGET}/before_defconf.sh" ] && /bin/bash "$GITHUB_WORKSPACE/.env/${MYTARGET}/before_defconf.sh"

[ -d "devices/common/diy" ] && cp -Rf devices/common/diy/* ./
[ -d "devices/${MYTARGET}/diy" ] && cp -Rf devices/${MYTARGET}/diy/* ./
[ -d "$GITHUB_WORKSPACE/.env/${MYTARGET}/files" ] && cp -Rf "$GITHUB_WORKSPACE/.env/${MYTARGET}/files" ./

[ $UPDATE_REPO == "true" ] && ./scripts/feeds clean
[ $UPDATE_REPO == "true" ] && ./scripts/feeds update -a

# Use Lienol's https-dns-proxy package
pushd feeds/packages/net
[ $UPDATE_REPO == "true" ] && rm -rf https-dns-proxy
svnClone https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
popd

# Use snapshots syncthing package
pushd feeds/packages/utils
[ $UPDATE_REPO == "true" ] && rm -rf syncthing
svnClone https://github.com/openwrt/packages/trunk/utils/syncthing
popd


[ $UPDATE_REPO == "true" ] && ./scripts/feeds install -a

# [[ ! -f "$OPENWRTROOT/files/etc/uci-defaults/99-init-settings" ]] && echo "ERRORRRRR: missing files!"
