#!/bin/bash
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

# Svn checkout packages from immortalwrt's repository
pushd customfeeds

svnClone https://github.com/coolsnowwolf/packages/branches/openwrt-19.07/devel devel
# rm packages/devel/meson
[[ -L packages/devel/ninja ]] && rm packages/devel/ninja
# ln -s $PWD/devel/meson packages/devel/
ln -s $PWD/devel/ninja packages/devel/
# svnClone https://github.com/openwrt/openwrt/trunk/include
# rm ../include/meson.mk
# ln -s $PWD/include/meson.mk ../include/meson.mk

# Add luci-app-eqos
svnClone https://github.com/immortalwrt/luci/trunk/applications/luci-app-eqos luci/applications/luci-app-eqos

# Add luci-proto-modemmanager
svnClone https://github.com/immortalwrt/luci/trunk/protocols/luci-proto-modemmanager luci/protocols/luci-proto-modemmanager

# Add luci-app-gowebdav
svnClone https://github.com/immortalwrt/luci/trunk/applications/luci-app-gowebdav luci/applications/luci-app-gowebdav
svnClone https://github.com/immortalwrt/packages/trunk/net/gowebdav packages/net/gowebdav

# add libssh
svnClone https://github.com/openwrt/packages/trunk/libs/libssh packages/libs/libssh

# Add luci-app-netdata
# rm -rf packages/admin/netdata
# svnClone https://github.com/281677160/openwrt-package/trunk/feeds/packages/net/netdata packages/admin/netdata
# rm -rf ../package/lean/luci-app-netdata
# svnClone https://github.com/281677160/openwrt-package/trunk/feeds/luci/applications/luci-app-netdata luci/applications/luci-app-netdata

# Add Easymesh
# svnClone https://github.com/ntlf9t/luci-app-easymesh/trunk luci/applications/luci-app-easymesh

# Add gotop
svnClone https://github.com/immortalwrt/packages/branches/openwrt-18.06/admin/gotop packages/admin/gotop

# Add minieap
svnClone https://github.com/immortalwrt/packages/trunk/net/minieap packages/net/minieap

# Replace smartdns with the official version
# rm -rf packages/net/smartdns
# svnClone https://github.com/openwrt/packages/trunk/net/smartdns packages/net/smartdns
popd

echo "hook-feeds done."
