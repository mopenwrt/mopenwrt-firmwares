#!/bin/bash

# remove $2:ext-name from filename
function getFileNameNoExt() {
  local dir=`dirname $1`
  local basename="$1"
  [[ -n "$1" && -n $2 ]] && basename=`basename -s $2 $1`
  [[  -n $dir && $dir != '.' ]] && basename=$dir/$basename
  echo $basename
  # echo getFileNameNoExt Result $basename >&2
}

function gitClone() {
  local POSITIONAL=()
  local DEPTH="--depth=1"
  local BRANCH=""
  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
      -b|--branch)
        BRANCH="$1 $2"
        shift # past argument
        shift # past value
        ;;
      --depth=*)
        DEPTH="$1"
        shift # past argument=value
        ;;
      *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
  done

  set -- "${POSITIONAL[@]}" # restore positional parameters

  local url=$1
  local dir=${2:-`basename ${url}`}
  # echo gitclone $url $dir
  # local mdir=`dirname $dir`
  dir=$(getFileNameNoExt $dir .git)
  if [ -f "$dir/.git/config" ]; then
    echo "git pull $url to $dir"
    git -C "$dir" pull
  else
    # rm -fr $dir
    echo "git clone $DEPTH $BRANCH $url to $dir"
    git clone $DEPTH $BRANCH $url $dir
  fi
}

function svnClone() {
  local url=$1
  local dir=${2:-`basename ${url}`}
  # dir=${dir%.*}
  if [ -d "$dir/.svn" ]; then
    echo "svn update $url to $dir"
    svn up "$dir"
  else
    # rm -fr $dir
    echo "svn clone $url to $dir"
    svn co $url $dir
  fi
}

