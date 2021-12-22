#!/bin/bash

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [ "$KMODS_IN_FIRMWARE" = 'true' ]; then
  echo "enable KMODS_IN_FIRMWARE"
  echo "CONFIG_ALL_NONSHARED=y" >> .config
fi

if [[ "$USE_ZSH" == "true" ]]; then
  /bin/bash $GITHUB_WORKSPACE/scripts/preset-terminal-tools.sh
fi

if [[ "$MULTI_LANG" == "true" ]]; then
  # /usr/bin/crudini --merge .config < $SCRIPT_DIR/multi-lang.config
  $SCRIPT_DIR/multi-lang.config >> .config
else
  DEFAULT_LANG=${DEFAULT_LANG:="en"}
  # echo "CONFIG_LUCI_LANG_$DEFAULT_LANG=y" | /usr/bin/crudini --merge .config
  echo "CONFIG_LUCI_LANG_$DEFAULT_LANG=y" >> .config
fi

if [[ "$USB_PRINT" == "true" ]]; then
  echo "CONFIG_PACKAGE_kmod-usb-printer=y" >> .config
  echo "CONFIG_PACKAGE_luci-app-usb-printer=y" >> .config
# /usr/bin/crudini --merge .config <<EOF
# CONFIG_PACKAGE_kmod-usb-printer=y
# CONFIG_PACKAGE_luci-app-usb-printer=y
# EOF
fi

if [[ "$USB_STORAGE" == "true" ]]; then
  echo "
CONFIG_PACKAGE_kmod-usb-storage=y
CONFIG_PACKAGE_kmod-usb-storage-extras=y
CONFIG_PACKAGE_kmod-usb-storage-uas=y
CONFIG_PACKAGE_luci-app-hd-idle=y
CONFIG_PACKAGE_luci-app-nfs=y
CONFIG_PACKAGE_luci-app-nft-qos=y
CONFIG_PACKAGE_luci-app-cifs-mount=y
CONFIG_PACKAGE_luci-app-filetransfer=y
CONFIG_PACKAGE_luci-app-aria2=y
CONFIG_PACKAGE_automount=y
CONFIG_PACKAGE_resize2fs=y
CONFIG_PACKAGE_ariang=y
CONFIG_ARIA2_ASYNC_DNS=y
CONFIG_ARIA2_BITTORRENT=y
CONFIG_ARIA2_COOKIE=y
CONFIG_ARIA2_EXPAT=y
CONFIG_ARIA2_METALINK=y
CONFIG_ARIA2_OPENSSL=y
CONFIG_ARIA2_SFTP=y
CONFIG_ARIA2_WEBSOCKET=y
CONFIG_PACKAGE_fdisk=y

CONFIG_PACKAGE_libimobiledevice-utils=y
CONFIG_PACKAGE_libplist-utils=y
CONFIG_PACKAGE_libusbmuxd-utils=y
CONFIG_PACKAGE_usbmuxd=y
CONFIG_PACKAGE_libudev-fbsd=y
" >> .config
fi

if [[ "$USE_SAMBA4" == "true" ]]; then
  echo "
CONFIG_PACKAGE_luci-app-samba4=y
CONFIG_PACKAGE_samba4-admin=y
CONFIG_PACKAGE_samba4-client=y
CONFIG_PACKAGE_samba4-libs=y
CONFIG_PACKAGE_samba4-server=y
CONFIG_SAMBA4_SERVER_AVAHI=y
CONFIG_SAMBA4_SERVER_NETBIOS=y
CONFIG_SAMBA4_SERVER_VFS=y
CONFIG_SAMBA4_SERVER_VFSX=y
CONFIG_SAMBA4_SERVER_WSDD2=y
# disable the lean's defaults samba3
# CONFIG_PACKAGE_autosamba is not set
# CONFIG_DEFAULT_autosamba is not set
# CONFIG_PACKAGE_luci-app-samba is not set
# CONFIG_PACKAGE_samba36-server is not set
" >> .config
fi

if [[ "$DISABLE_KMS_SERVER" == "true" ]]; then
  echo "
# CONFIG_PACKAGE_vlmcsd is not set
# CONFIG_PACKAGE_luci-app-vlmcsd is not set
" >> .config
fi


if [[ "$DISABLE_SSR_PLUS" == "true" ]]; then
  echo "
# CONFIG_PACKAGE_luci-app-ssr-plus is not set
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client is not set
" >> .config
fi

if [[ "$DISABLE_FTP_SERVER" == "true" ]]; then
  echo "# CONFIG_PACKAGE_luci-app-vsftpd is not set" >> .config
fi

if [[ "$DISABLE_DDNS" == "true" ]]; then
  echo "
# CONFIG_DEFAULT_luci-app-ddns is not set
# CONFIG_PACKAGE_ddns-scripts is not set
# CONFIG_PACKAGE_ddns-scripts_aliyun is not set
# CONFIG_PACKAGE_ddns-scripts_dnspod is not set
" >> .config
fi
