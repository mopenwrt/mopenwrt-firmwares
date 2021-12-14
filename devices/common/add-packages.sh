#!/bin/bash

function gitClone() {
  local POSITIONAL=()
  local DEPTH="--depth=1"
  local BRANCH=""
  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
      -b|--branch)
        BRANCH="$1 $2"
        shift # past argument
        shift # past value
        ;;
      --depth=*)
        DEPTH="$1"
        shift # past argument=value
        ;;
      *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
  done

  set -- "${POSITIONAL[@]}" # restore positional parameters

  local url=$1
  local dir=${2:-`basename ${url}`}
  dir=${dir%.*}
  if [ -f "$dir/.git/config" ]; then
    echo "git pull $url to $dir"
    git -C "$dir" pull
  else
    # rm -fr $dir
    echo "git clone $DEPTH $BRANCH $url to $dir"
    git clone $DEPTH $BRANCH $url $dir
  fi
}

function svnClone() {
  local url=$1
  local dir=${2:-`basename ${url}`}
  dir=${dir%.*}
  if [ -d "$dir/.svn" ]; then
    echo "svn update $url to $dir"
    svn up "$dir"
  else
    # rm -fr $dir
    echo "svn clone $url to $dir"
    svn co $url $dir
  fi
}


# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Lienol's Packages
gitClone https://github.com/Lienol/openwrt-package
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-verysync

# Add luci-app-ssr-plus
gitClone https://github.com/fw876/helloworld.git

# Add luci-app-unblockneteasemusic
rm -rf ../lean/luci-app-unblockmusic
gitClone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git

# Add luci-app-passwall
#gitClone https://github.com/xiaorouji/openwrt-passwall

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

# Add luci-app-oled (R2S Only)
gitClone https://github.com/NateLol/luci-app-oled

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

# Add luci-theme-argon
gitClone -b 18.06 https://github.com/jerrykuku/luci-theme-argon
gitClone https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon

# Add subconverter
# https://github.com/tindy2013/subconverter
# https://github.com/CareyWang/sub-web
gitClone https://github.com/tindy2013/openwrt-subconverter

# Add extra wireless drivers
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8812au-ac
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8821cu
svnClone https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8188eu
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
popd

# Add cpufreq
rm -rf package/lean/luci-app-cpufreq
svnClone https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq

# Add luci-aliyundrive-webdav
svnClone https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
svnClone https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav

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

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

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

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Add po2lmo
gitClone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
# make && sudo make install
popd

rm -rf ./package/kernel/linux/modules/video.mk
wget -P package/kernel/linux/modules/ https://github.com/immortalwrt/immortalwrt/raw/master/package/kernel/linux/modules/video.mk

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/192.168.16.1/g' package/base-files/files/bin/config_generate
sed -i '/uci commit system/i\uci set system.@system[0].hostname='FusionWrt'' package/lean/default-settings/files/zzz-default-settings
sed -i "s/OpenWrt /DHDAXCW @ FusionWrt $(TZ=UTC-8 date "+%Y%m%d") /g" package/lean/default-settings/files/zzz-default-settings
# find package/*/ feeds/*/ -maxdepth 6 -path "*luci-app-smartdns/luasrc/controller/smartdns.lua" | xargs -i sed -i 's/\"SmartDNS\")\, 4/\"SmartDNS\")\, 3/g' {}
# Test kernel 5.10
# sed -i 's/5.4/5.10/g' target/linux/rockchip/Makefile

# Custom configs
# git am $GITHUB_WORKSPACE/patches/lean/*.patch
# git am $GITHUB_WORKSPACE/patches/*.patch
echo -e " DHDAXCW's FusionWrt built on "$(date +%Y.%m.%d)"\n -----------------------------------------------------" >> package/base-files/files/etc/banner
echo 'net.bridge.bridge-nf-call-iptables=0' >> package/base-files/files/etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-ip6tables=0' >> package/base-files/files/etc/sysctl.conf
echo 'net.bridge.bridge-nf-call-arptables=0' >> package/base-files/files/etc/sysctl.conf
echo 'net.bridge.bridge-nf-filter-vlan-tagged=0' >> package/base-files/files/etc/sysctl.conf
# Add CUPInfo
# pushd package/lean/autocore/files/arm/sbin
# cp -f $GITHUB_WORKSPACE/scripts/cpuinfo cpuinfo
# popd
