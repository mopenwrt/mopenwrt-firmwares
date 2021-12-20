#!/bin/bash

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

GITHUB_WORKSPACE=$SCRIPT_DIR/../..
export GITHUB_WORKSPACE="`cd "${GITHUB_WORKSPACE}";pwd`"
OPENWRTROOT=$GITHUB_WORKSPACE/openwrt

echo GITHUB_WORKSPACE: $GITHUB_WORKSPACE
export GITHUB_ENV=$PWD/.github-env
#MYTARGET=${{matrix.target}}
MYTARGET=rockchip

echo > $GITHUB_ENV

. $SCRIPT_DIR/01-load-settings.sh
set -o allexport
. $GITHUB_ENV
set +o allexport

# clean
#cd $OPENWRTROOT
#rm -fr bin feeds customfeeds
