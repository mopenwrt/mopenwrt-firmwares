#!/bin/bash
( sudo -E apt-get -qq update
  sudo -E apt-get -qq install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc-s1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx-ucl libelf-dev autoconf automake libtool autopoint device-tree-compiler ccache xsltproc rename antlr3 gperf wget curl swig rsync
  ${GITHUB_WORKSPACE}/scripts/free_disk_space.sh ) &
sudo timedatectl set-timezone "$TZ"
