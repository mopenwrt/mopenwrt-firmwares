#!/bin/bash

source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"
gitClone $REPO_URL -b $REPO_BRANCH $OPENWRTROOT
