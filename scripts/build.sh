#!/bin/bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

MYTARGET=WNDR4300v1
# MYTARGET=rockchip

# GITHUB_WORKSPACE=$SCRIPT_PATH/..
. $SCRIPT_PATH/clone-repo.sh

. $SCRIPT_PATH/steps/00-local.sh
. $SCRIPT_PATH/steps/01-load-settings.sh
set -o allexport
. $GITHUB_ENV
set +o allexport

# clean
pushd $OPENWRTROOT
rm -fr bin files
# rm -fr feeds customfeeds package/community
popd

if [ -f $OPENWRTROOT/.git/config ]; then
  rm -fr $OPENWRTROOT/bin
  git -C $OPENWRTROOT checkout -f .
fi

gitClone -b $REPO_BRANCH $REPO_URL $OPENWRTROOT

$SCRIPT_PATH/steps/04-load-custom-config.sh
$SCRIPT_PATH/steps/05-apply-patch.sh
$SCRIPT_PATH/steps/06-make-config.sh
[ SKIP_DOWNLOAD_PACKAGES != "true" ] && $SCRIPT_PATH/steps/07-download-packages.sh
. $SCRIPT_PATH/steps/08-compile.sh
$SCRIPT_PATH/steps/09-generate-firmware.sh
