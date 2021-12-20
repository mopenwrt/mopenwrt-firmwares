#!/bin/bash

cd $OPENWRTROOT
echo -e "$NUMCORES thread compile"
make tools/compile -j$NUMCORES || make tools/compile -j1 V=s
make toolchain/compile -j$NUMCORES || make toolchain/compile -j1 V=s
make target/compile -j$NUMCORES || make target/compile -j1 V=s IGNORE_ERRORS=1
make diffconfig
make package/compile -j$NUMCORES IGNORE_ERRORS=1 || make package/compile -j1 V=s IGNORE_ERRORS=1
make package/index
cd $OPENWRTROOT/bin/packages/*
PLATFORM=$(basename `pwd`)
echo "PLATFORM=$PLATFORM" >> $GITHUB_ENV
echo "::set-output name=PLATFORM::$(echo $PLATFORM)"
cd $OPENWRTROOT/bin/targets/*
TARGET=$(basename `pwd`)
echo "TARGET=$TARGET" >> $GITHUB_ENV
echo "::set-output name=TARGET::$(echo $TARGET)"
cd *
SUBTARGET=$(basename `pwd`)
echo "SUBTARGET=$SUBTARGET" >> $GITHUB_ENV
echo "::set-output name=SUBTARGET::$(echo $SUBTARGET)"
echo "FIRMWARE=$PWD" >> $GITHUB_ENV
echo "::set-output name=FIRMWARE::$(echo $PWD)"
echo "::set-output name=COMPILE_STATUS::success"
