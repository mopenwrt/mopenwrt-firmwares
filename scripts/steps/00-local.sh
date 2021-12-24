#!/bin/bash

# SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SCRIPT_DIR="${BASH_SOURCE[0]}"
if [ ! -z $SCRIPT_DIR ]; then
  pushd . > /dev/null
  if [ -h "${SCRIPT_DIR}" ]; then
    while ([ -h "${SCRIPT_DIR}" ]); do
      cd "$(dirname "$SCRIPT_DIR")"
      SCRIPT_DIR=$(readlink "${SCRIPT_DIR}")
    done
  fi
  cd "$(dirname ${SCRIPT_DIR})" > /dev/null
  SCRIPT_DIR=$(pwd);
  popd  > /dev/null
fi
SCRIPT_DIR=${SCRIPT_DIR:="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"}
echo SCRIPT_DIR=$SCRIPT_DIR
# [ -z $GITHUB_WORKSPACE ] && GITHUB_WORKSPACE=$SCRIPT_DIR/../..
GITHUB_WORKSPACE=$SCRIPT_DIR/../..
export GITHUB_WORKSPACE="`cd "${GITHUB_WORKSPACE}";pwd`"
OPENWRTROOT=${OPENWRTROOT:="$GITHUB_WORKSPACE/openwrt"}

echo GITHUB_WORKSPACE: $GITHUB_WORKSPACE
export GITHUB_ENV=$GITHUB_WORKSPACE/.github-env
[ -z $MYTARGET ] && MYTARGET=${{matrix.target}}
# MYTARGET=WNDR4300v1
