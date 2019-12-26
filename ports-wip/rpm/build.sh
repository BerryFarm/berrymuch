#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="rpm-4.13.1-release"
DISTFILES="https://github.com/rpm-software-management/rpm.git"
DISTSUFFIX="git"

BUILD_DEP_BINS=(libtool glibtoolize)
check_required_binaries

TASK=fetch
package_init "$@"
CONFIGURE_CMD="./autogen.sh;
		./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
                "


if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  #rm -rf "$DISTVER"
  git clone $DISTFILES $DISTVER
  cd $DISTVER
  git checkout $DISTVER
  TASK=patch
fi

package_patch 1

if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"
  # clean up if we have a previous build
  #if [ -e "Makefile" ]; then
  #  make clean || true
  #  make distclean || true
  #fi
  # configure
  # autoconf
  eval $CONFIGURE_CMD
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle

