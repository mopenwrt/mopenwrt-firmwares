#!/bin/bash

shopt -s globstar
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

cd $OPENWRTROOT

[ -f "devices/common/before_defconf.sh" ] && /bin/bash devices/common/before_defconf.sh
[ -f "devices/${MYTARGET}/before_defconf.sh" ] && /bin/bash devices/${MYTARGET}/before_defconf.sh

[ -d "devices/common/diy" ] && cp -Rf devices/common/diy/* ./
[ -d "devices/${MYTARGET}/diy" ] && cp -Rf devices/${MYTARGET}/diy/* ./

[ $UPDATE_REPO == "true" ] && ./scripts/feeds clean
./scripts/feeds update -a

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


./scripts/feeds install -a
