#!/bin/bash

if [ $SKIP_COMPILE != "true" ]; then
  cd $OPENWRTROOT
  echo -e "$NUMCORES thread compile"
  make tools/compile -j$NUMCORES || make tools/compile -j1 V=s
  make toolchain/compile -j$NUMCORES || make toolchain/compile -j1 V=s
  make target/compile -j$NUMCORES || make target/compile -j1 V=s IGNORE_ERRORS=1
  make diffconfig
  make package/compile -j$NUMCORES IGNORE_ERRORS=1 || make package/compile -j1 V=s IGNORE_ERRORS=1
  make package/index
fi

cd $OPENWRTROOT/bin/packages/*
export PLATFORM=$(basename `pwd`)
cd $OPENWRTROOT/bin/targets/*
export TARGET=$(basename `pwd`)
cd *
export SUBTARGET=$(basename `pwd`)
export FIRMWARE=$PWD
cd $OPENWRTROOT

echo "PLATFORM=$PLATFORM" >> $GITHUB_ENV
echo "::set-output name=PLATFORM::$(echo $PLATFORM)"
echo "TARGET=$TARGET" >> $GITHUB_ENV
echo "::set-output name=TARGET::$(echo $TARGET)"
echo "SUBTARGET=$SUBTARGET" >> $GITHUB_ENV
echo "::set-output name=SUBTARGET::$(echo $SUBTARGET)"
echo "FIRMWARE=$FIRMWARE" >> $GITHUB_ENV
echo "::set-output name=FIRMWARE::$(echo $FIRMWARE)"
echo "::set-output name=COMPILE_STATUS::success"
