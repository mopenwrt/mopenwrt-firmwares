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
  cat $SCRIPT_DIR/multi-lang.config >> .config
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
else
  echo "
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Kcptun=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_NaiveProxy=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Redsocks2=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Libev_Client=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Libev_Server=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Rust_Client=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Shadowsocks_Rust_Server=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Server=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Simple_Obfs=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Trojan=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_V2ray_Plugin=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-ssr-mudb-server=y
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
else
  echo "
CONFIG_PACKAGE_ddns-scripts_cloudflare.com-v4=y
CONFIG_PACKAGE_ddns-scripts_freedns_42_pl=y
CONFIG_PACKAGE_ddns-scripts_godaddy.com-v1=y
CONFIG_PACKAGE_ddns-scripts_no-ip_com=y
CONFIG_PACKAGE_ddns-scripts_nsupdate=y
CONFIG_PACKAGE_ddns-scripts_route53-v1=y
CONFIG_PACKAGE_luci-app-tencentddns=y
# NPS内网穿透
CONFIG_PACKAGE_luci-app-nps=y
" >> .config
fi

if [[ "$USE_PASSWALL" == "true" ]]; then
  echo "
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Server=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Server=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_GO=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_NaiveProxy=n
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Kcptun=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Haproxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Dns2socks=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Simple_Obfs=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray-plugin=y
" >> .config
fi

if [[ "$USE_VSSR" == "true" ]]; then
  echo "
CONFIG_PACKAGE_luci-app-vssr=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Trojan=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Kcptun=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Xray_plugin=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ShadowsocksR_Server=y
" >> .config
fi

if [[ "$USE_VPN" == "true" ]]; then
  echo "
CONFIG_PACKAGE_luci-app-n2n_v2=y
CONFIG_PACKAGE_luci-app-zerotier=y
CONFIG_PACKAGE_luci-app-wireguard=y
CONFIG_PACKAGE_luci-app-pptp-server=y
CONFIG_PACKAGE_luci-app-ipsec-server=y
# CONFIG_PACKAGE_luci-app-ipsec-vpnd is not set
CONFIG_PACKAGE_luci-app-softethervpn=y
CONFIG_PACKAGE_luci-app-openvpn-server=y
" >> .config
else
  echo "
# CONFIG_PACKAGE_luci-app-ssr-mudb-server is not set
" >> .config
fi

if [[ "$USE_MINIEAP" == "true" ]]; then
  echo "
CONFIG_PACKAGE_minieap=y
# CONFIG_PACKAGE_mentohust=y
CONFIG_PACKAGE_luci-proto-minieap=y
" >> .config
fi

if [[ "$USE_MESH" == "true" ]]; then
  echo "
CONFIG_PACKAGE_kmod-batman-adv=y
CONFIG_PACKAGE_luci-app-easymesh=y
# CONFIG_PACKAGE_wpad-openssl is not set
CONFIG_PACKAGE_wpad-mesh-openssl=y
" >> .config
else
  echo "
# CONFIG_PACKAGE_wpad is not set
# CONFIG_PACKAGE_wpad-mini is not set
CONFIG_PACKAGE_wpad-openssl=y
CONFIG_PACKAGE_luci-app-easymesh is not set
" >> .config
fi
