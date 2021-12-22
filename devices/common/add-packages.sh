#!/bin/bash
echo "add&patch kernel packages"
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

# Clone community packages to package/community
mkdir package/community
pushd package/community

echo Add community packages to package/community

# Add Lienol's Packages
gitClone https://github.com/Lienol/openwrt-package
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-verysync

# Add tmate # Error on MIPS:  No rule to make target 'compat/forkpty-linux.c
# gitClone https://github.com/immortalwrt/openwrt-tmate
svnClone https://github.com/immortalwrt/openwrt-tmate/trunk/msgpack-c

# Add naiveproxy
gitClone https://github.com/immortalwrt-collections/openwrt-naiveproxy

# Add luci-app-ssr-plus
gitClone https://github.com/fw876/helloworld.git

# Add luci-app-passwall
gitClone https://github.com/xiaorouji/openwrt-passwall
# gitClone -b hello https://github.com/DHDAXCW/openwrt-passwall luci/applications/openwrt-passwall

# Add luci-app-unblockneteasemusic
rm -rf ../lean/luci-app-unblockmusic
gitClone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git

# Add luci-app-vssr <M>
gitClone https://github.com/jerrykuku/lua-maxminddb.git
gitClone https://github.com/jerrykuku/luci-app-vssr

# Add mentohust & luci-app-mentohust
gitClone https://github.com/BoringCat/luci-app-mentohust
gitClone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# Add luci-proto-minieap
gitClone https://github.com/ysc3839/luci-proto-minieap

# Add luci-app-bypass
# gitClone https://github.com/garypang13/luci-app-bypass.git

# Add OpenClash
gitClone https://github.com/vernesong/OpenClash

# Add luci-app-onliner (need luci-app-nlbwmon)
gitClone https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome
svnClone https://github.com/Lienol/openwrt-package/branches/other/luci-app-adguardhome

# Add ddnsto & linkease
svnClone https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto
svnClone https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease
svnClone https://github.com/linkease/nas-packages/trunk/network/services/ddnsto
svnClone https://github.com/linkease/nas-packages/trunk/network/services/linkease

# Add luci-app-diskman
# gitClone https://github.com/SuLingGG/luci-app-diskman
# mkdir parted
# cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-ikoolproxy (godproxy)
gitClone https://github.com/iwrt/luci-app-ikoolproxy.git

# Add luci-app-dockerman
rm -rf ../lean/luci-app-docker
rm -rf ../lean/luci-app-dockerman
gitClone https://github.com/lisaac/luci-app-dockerman
gitClone https://github.com/lisaac/luci-lib-docker

# Add luci-theme-argon config
gitClone https://github.com/jerrykuku/luci-app-argon-config
# update the luci-theme-argon
# rm -rf package/lean/luci-theme-argon
gitClone -b 18.06 https://github.com/jerrykuku/luci-theme-argon
# svnClone https://github.com/jerrykuku/luci-theme-argon/branches/18.06 package/lean/luci-theme-argon-18.06

# Add subconverter
# https://github.com/tindy2013/subconverter
# https://github.com/CareyWang/sub-web
gitClone https://github.com/tindy2013/openwrt-subconverter

# Add extra wireless drivers
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8812au-ac
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8821cu
# svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8188eu
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8192eu
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl88x2bu

# Add luci-app-smartdns & smartdns
svnClone https://github.com/281677160/openwrt-package/trunk/feeds/luci/applications/luci-app-smartdns
# svnClone https://github.com/281677160/openwrt-package/trunk/feeds/packages/net/smartdns
# svnClone https://github.com/OpenWrt-Actions/OpenWrt-Packages/trunk/smartdns
# svnClone https://github.com/OpenWrt-Actions/OpenWrt-Packages/trunk/luci-app-smartdns
svnClone https://github.com/openwrt/packages/trunk/net/smartdns
# sed -i 's/PKG_MIRROR_HASH:=.*//g' smartdns/Makefile
# svnClone https://github.com/openwrt/luci/trunk/applications/luci-app-smartdns

# Add apk (Apk Packages Manager)
svnClone https://github.com/openwrt/packages/trunk/utils/apk

# Add luci-udptools
svnClone https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools
svnClone https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw
svnClone https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder-tunnel

# Add OpenAppFilter
gitClone https://github.com/destan19/OpenAppFilter

# Add luci-aliyundrive-webdav
svnClone https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
svnClone https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav

# Add Easymesh
rm -rf ../lean/luci-app-easymesh
svnClone https://github.com/ntlf9t/luci-app-easymesh/trunk luci-app-easymesh

# Add cpufreq
rm -rf ../lean/luci-app-cpufreq
svnClone https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq luci-app-cpufreq
# svnClone https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
# ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq

popd

# # Add Easymesh
# [ $UPDATE_REPO == "true" ] && rm -rf package/lean/luci-app-easymesh
# svnClone https://github.com/ntlf9t/luci-app-easymesh/trunk package/lean/luci-app-easymesh

# 动态DNS
# gitClone https://github.com/small-5/ddns-scripts-dnspod package/lean/ddns-scripts_dnspod
# gitClone https://github.com/small-5/ddns-scripts-aliyun package/lean/ddns-scripts_aliyun
svnClone https://github.com/QiuSimons/OpenWrt_luci-app/trunk/luci-app-tencentddns package/lean/luci-app-tencentddns
svnClone https://github.com/kenzok8/openwrt-packages/trunk/luci-app-aliddns feeds/luci/applications/luci-app-aliddns
ln -sf ../../../feeds/luci/applications/luci-app-aliddns ./package/feeds/luci/luci-app-aliddns

# Add Pandownload
pushd package/lean
svnClone https://github.com/immortalwrt/packages/trunk/net/pandownload-fake-server
popd

# Add po2lmo
gitClone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
# make && sudo make install
popd

echo "add&patch packages done."
