#!/bin/bash
#=================================================
shopt -s extglob

source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

pushd package/community

# Add luci-app-oled (R2S Only)
gitClone https://github.com/NateLol/luci-app-oled

popd

# sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
# sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
# sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1608,1800,g' package/lean/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,2016,2208,g' package/lean/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1512,1608,g' package/lean/luci-app-cpufreq/root/etc/uci-defaults/cpufreq


[ ! -f target/linux/rockchip/armv8/base-files/etc/init.d/fa-rk3399-pwmfan ] && wget -P target/linux/rockchip/armv8/base-files/etc/init.d/ https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3399/base-files/etc/init.d/fa-rk3399-pwmfan
[ ! -f target/linux/rockchip/armv8/base-files/usr/bin/start-rk3399-pwm-fan.sh ] && wget -P target/linux/rockchip/armv8/base-files/usr/bin/ https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3399/base-files/usr/bin/start-rk3399-pwm-fan.sh
# wget -P target/linux/rockchip/patches-5.4 https://raw.githubusercontent.com/DHDAXCW/package_target/master/107-Add-support-for-off-on-delay-kernel-5.4.patch

$GITHUB_WORKSPACE/scripts/preset-clash-core.sh armv8
