#!/bin/bash
#=================================================
shopt -s extglob

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

/bin/bash "${SCRIPT_DIR}/customfeeds.sh"

/bin/bash "${SCRIPT_DIR}/add-packages.sh"

