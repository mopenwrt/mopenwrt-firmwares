#!/bin/bash
#=================================================
shopt -s extglob

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

/bin/bash "${SCRIPT_DIR}/customfeeds.sh"
./scripts/feeds install -a
