#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

BUILD_DEP_BINS=(libtool)
check_required_binaries

DISTVER="db-4.8.30"
DISTFILES="https://src.fedoraproject.org/lookaside/pkgs/db4/$DISTVER.tar.gz/f80022099c5742cd179343556179aa8c/$DISTVER.tar.gz"
DISTSUFFIX="tar.gz"
UNPACKCOMD="tar -xzf"
TASK=fetch

package_init "$@"
CONFIGURE_CMD=" ../dist/configure
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
  cd "$WORKDIR/build_unix"
  # clean up if we have a previous build
  #if [ -e "Makefile" ]; then
  #  make clean || true
  #  make distclean || true
  #fi
  # configure
  eval $CONFIGURE_CMD
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make -C build_unix DESTDIR="$DESTDIR" install
  TASK=bundle
fi

package_bundle


