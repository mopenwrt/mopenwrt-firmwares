#!/bin/bash
#=================================================
shopt -s extglob

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# mips_24kc: mipsle-hardfloat
[ $USE_CLASH == "true" ] && $GITHUB_WORKSPACE/scripts/preset-clash-core.sh mipsle-hardfloat
