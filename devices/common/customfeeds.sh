#!/bin/bash
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"
SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir customfeeds

echo add custom feeds

gitClone https://github.com/coolsnowwolf/packages customfeeds/packages
gitClone https://github.com/coolsnowwolf/luci customfeeds/luci

/bin/bash "${SCRIPT_DIR}/hook-feeds.sh"

# Set to local feeds
pushd customfeeds/packages
export packages_feed="$(pwd)"
popd
pushd customfeeds/luci
export luci_feed="$(pwd)"
popd

echo packages_feed=$packages_feed luci_feed=$luci_feed
if ! grep -q "$packages_feed" feeds.conf.default ; then
  sed -i '/src-git packages/d' feeds.conf.default
  echo "src-link packages $packages_feed" >> feeds.conf.default
fi
if ! grep -q "$luci_feed" feeds.conf.default ; then
  sed -i '/src-git luci/d' feeds.conf.default
  echo "src-link luci $luci_feed" >> feeds.conf.default
fi
echo "cur: $PWD"
rm -fr customfeeds/packages/utils/apk # added into package/community(kernel packages)

# WARNING: Makefile 'package/lean/luci-app-turboacc/Makefile' has a dependency on 'dnsproxy', which does not exist
ln -s $PWD/customfeeds/packages/net/dnsproxy package/lean/

echo "custom feeds done."
