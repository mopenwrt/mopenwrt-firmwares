#!/bin/bash

copyFeeds() {
  cp $1 $2
  sed -i "s/subtarget/$SUBTARGET/g;s/target\//$TARGET\//g;s/platform/$PLATFORM/g" $2
}

cd $OPENWRTROOT
mkdir -p files/etc/opkg
copyFeeds $GITHUB_WORKSPACE/configs/opkg/distfeeds-packages-server.conf files/etc/opkg/distfeeds.conf.server
mkdir -p files/etc/opkg/keys
cp $GITHUB_WORKSPACE/configs/opkg/1035ac73cc4e59e3 files/etc/opkg/keys/1035ac73cc4e59e3
echo "KMODS_IN_FIRMWARE=$KMODS_IN_FIRMWARE"
if [[ "$KMODS_IN_FIRMWARE" == "true" ]]; then
  echo "install packages in local"
  mkdir -p files/www/snapshots/targets/$TARGET/$SUBTARGET
  cp -r bin/targets/$TARGET/$SUBTARGET/{packages,config.buildinfo,public.key} files/www/snapshots/targets/$TARGET/$SUBTARGET/
  copyFeeds $GITHUB_WORKSPACE/configs/opkg/distfeeds-18.06-local.conf files/etc/opkg/distfeeds.conf
else
  copyFeeds $GITHUB_WORKSPACE/configs/opkg/distfeeds-18.06-remote.conf files/etc/opkg/distfeeds.conf
fi
cp files/etc/opkg/distfeeds.conf.server files/etc/opkg/distfeeds.conf.mirror
sed -i "s/http:\/\/192.168.123.100:2345\/snapshots/https:\/\/openwrt.cc\/snapshots/g" files/etc/opkg/distfeeds.conf.mirror
echo "IPV6MOD_IN_FIRMWARE=$IPV6MOD_IN_FIRMWARE"
if [[ "$IPV6MOD_IN_FIRMWARE" == "true" ]]; then
  echo "install IPV6MOD IN FIRMWARE"
  mkdir -p files/www/ipv6-modules
  cp bin/packages/$PLATFORM/luci/luci-proto-ipv6* files/www/ipv6-modules
  cp bin/packages/$PLATFORM/base/{ipv6helper*,odhcpd-ipv6only*,odhcp6c*,6in4*} "files/www/ipv6-modules"
  cp bin/targets/$TARGET/$SUBTARGET/packages/{ip6tables*,kmod-nf-nat6*,kmod-ipt-nat6*,kmod-sit*,kmod-ip6tables-extra*} "files/www/ipv6-modules"
  mkdir -p files/bin
  cp ipv6-helper.sh files/bin/ipv6-helper
fi
