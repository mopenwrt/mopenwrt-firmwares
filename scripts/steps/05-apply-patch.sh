#!/bin/bash

cd $OPENWRTROOT
GITREV=`git -C $OPENWRTROOT rev-parse --short HEAD`

rm -rf ./package/kernel/linux/modules/video.mk
wget -P package/kernel/linux/modules/ https://github.com/immortalwrt/immortalwrt/raw/master/package/kernel/linux/modules/video.mk


# Mod zzz-default-settings
pushd package/lean/default-settings/files
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} $GITREV(${date_version})/g" zzz-default-settings
popd


# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/192.168.16.1/g' package/base-files/files/bin/config_generate
sed -i '/uci commit system/i\uci set system.@system[0].hostname='mOpenWrt'' package/lean/default-settings/files/zzz-default-settings
sed -i "s/DISTRIB_DESCRIPTION='OpenWrt '/DISTRIB_DESCRIPTION='mOpenWrt '/g" package/lean/default-settings/files/zzz-default-settings
# find package/*/ feeds/*/ -maxdepth 6 -path "*luci-app-smartdns/luasrc/controller/smartdns.lua" | xargs -i sed -i 's/\"SmartDNS\")\, 4/\"SmartDNS\")\, 3/g' {}
# Test kernel 5.10
# sed -i 's/5.4/5.10/g' target/linux/rockchip/Makefile

# Custom configs
# git am $GITHUB_WORKSPACE/patches/lean/*.patch
# git am $GITHUB_WORKSPACE/patches/*.patch
! grep -q "mOpenWrt built on" package/base-files/files/etc/banner && echo -e " mOpenWrt built on "$GITREV-$(date +%Y.%m.%d)"\n -----------------------------------------------------" >> package/base-files/files/etc/banner
! grep -q 'net.bridge.bridge-nf-call-iptables=0' package/base-files/files/etc/sysctl.conf && echo 'net.bridge.bridge-nf-call-iptables=0'      >> package/base-files/files/etc/sysctl.conf
! grep -q 'net.bridge.bridge-nf-call-ip6tables=0' package/base-files/files/etc/sysctl.conf && echo 'net.bridge.bridge-nf-call-ip6tables=0'     >> package/base-files/files/etc/sysctl.conf
! grep -q 'net.bridge.bridge-nf-call-arptables=0' package/base-files/files/etc/sysctl.conf && echo 'net.bridge.bridge-nf-call-arptables=0'     >> package/base-files/files/etc/sysctl.conf
! grep -q 'net.bridge.bridge-nf-filter-vlan-tagged=0' package/base-files/files/etc/sysctl.conf && echo 'net.bridge.bridge-nf-filter-vlan-tagged=0' >> package/base-files/files/etc/sysctl.conf
# Add CUPInfo
# pushd package/lean/autocore/files/arm/sbin
# cp -f $GITHUB_WORKSPACE/scripts/cpuinfo cpuinfo
# popd

# cp -f devices/common/default-settings package/*/*/my-default-settings/files/uci.defaults
# if [ -f "devices/${MYTARGET}/default-settings" ]; then
#   echo >> package/*/*/my-default-settings/files/uci.defaults
#   cat devices/${MYTARGET}/default-settings >> package/*/*/my-default-settings/files/uci.defaults
# fi

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

if [ -n "$(ls -A "devices/common/patches" 2>/dev/null)" ]; then
  find "devices/common/patches" -type f ! -path 'devices/common/patches/china_mirrors.patch' -name '*.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 -E --forward --no-backup-if-mismatch"
fi

if [ -n "$(ls -A "devices/$MYTARGET/patches" 2>/dev/null)" ]; then
  find "devices/$MYTARGET/patches" -type f -name '*.patch' ! -name '*.revert.patch' -print0 | sort -z | xargs -I % -t -0 -n 1 sh -c "cat '%'  | patch -d './' -p1 -E --forward --no-backup-if-mismatch"
fi
