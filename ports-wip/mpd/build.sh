#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="mpd-0.20.21"
DISTSUFFIX="tar.xz"
TASK=fetch


DISTFILES="http://www.musicpd.org/download/mpd/0.20/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		CC=\"arm-unknown-nto-qnx8.0.0eabi-gcc-4.8.3\"
		AR=\"arm-unknown-nto-qnx8.0.0eabi-gcc-ar-4.8.3\"
		CPP=\"arm-unknown-nto-qnx8.0.0eabi-cpp-4.8.3\"
		CXX=\"arm-unknown-nto-qnx8.0.0eabi-g++-4.8.3\"
		CFLAGS=-O3
                "
#CC=$PBTARGETARCH-gcc

package_fetch
package_patch

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
  eval $CONFIGURE_CMD

  for apatch in $EXECDIR/post-conf-patches/*
   do
	 patch  < $apatch
   done

  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle

