#!/bin/bash

shopt -s globstar
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

[ -f "devices/common/before_defconf.sh" ] && /bin/bash devices/common/before_defconf.sh
[ -f "devices/${MYTARGET}/before_defconf.sh" ] && /bin/bash devices/${MYTARGET}/before_defconf.sh

[ -d "devices/common/diy" ] && cp -Rf devices/common/diy/* ./
[ -d "devices/${MYTARGET}/diy" ] && cp -Rf devices/${MYTARGET}/diy/* ./

./scripts/feeds clean
./scripts/feeds update -a

# Fix libssh
pushd feeds/packages/libs
rm -rf libssh
svnClone https://github.com/openwrt/packages/trunk/libs/libssh
popd

# Use Lienol's https-dns-proxy package
pushd feeds/packages/net
rm -rf https-dns-proxy
svnClone https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
popd

# Use snapshots syncthing package
pushd feeds/packages/utils
rm -rf syncthing
svnClone https://github.com/openwrt/packages/trunk/utils/syncthing
popd


./scripts/feeds install -a
