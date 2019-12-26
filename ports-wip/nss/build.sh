#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

BUILD_DEP_BINS=(ninja)
check_required_binaries

DISTVER="nss-3.39"
DISTFILES="https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_39_RTM/src/$DISTVER.tar.gz"
DISTSUFFIX="tar.gz"
UNPACKCOMD="tar -xzf"
TASK=fetch

package_init "$@"
CONFIGURE_CMD=" ./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
                "

package_fetch
#package_patch 1
TASK=build

if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR/nss"
  # clean up if we have a previous build
  #if [ -e "Makefile" ]; then
  #  make clean || true
  #  make distclean || true
  #fi
  # configure
  #eval $CONFIGURE_CMD
  #CC=arm-unknown-nto-qnx8.0.0eabi-gcc ./build.sh
  CC=arm-unknown-nto-qnx8.0.0eabi-gcc make nss_build_all 
  #eval $MAKE_PREFIX make $MYMAKEFLAGS || \
  #      eval $MAKE_PREFIX make
  TASK=install
fi

package_bundle
