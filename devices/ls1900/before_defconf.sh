#!/bin/bash
#=================================================
shopt -s extglob

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Cortex-A9: armv7
[ $USE_CLASH == "true" ] && $GITHUB_WORKSPACE/scripts/preset-clash-core.sh armv7
