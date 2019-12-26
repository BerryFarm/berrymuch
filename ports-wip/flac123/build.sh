#!/usr/bin/env bash

set -x

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018
#


set -e
source ../../lib.sh
DISTVER="flac123-0.0.11"
DISTSUFFIX="tar.gz"
TASK=fetch


#DISTFILES="http://prdownloads.sourceforge.net/flac-tools/$DISTVER.$DISTSUFFIX?download"
DISTFILES="http://54.37.67.113/bb10/misc/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		CC=\"arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3\"
		AR=\"arm-unknown-nto-qnx8.0.0eabi-gcc-ar-4.6.3\"
		CPP=\"arm-unknown-nto-qnx8.0.0eabi-cpp-4.6.3\"
		CXX=\"arm-unknown-nto-qnx8.0.0eabi-g++-4.6.3\"
		CFLAGS=\"-O3 -I../flac-1.3.2/include -I../popt-1.16 -I../libao-1.2.0/include\"
		LDFLAGS=\"-O3 -fPIC -L../flac-1.3.2/src/libFLAC/.libs -lFLAC -L../popt-1.16/.libs -lpopt -lao -L../libao-1.2.0/src/.libs\"
                "
if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  echo "Fetching sources"
  if [ ! -f $DISTVER.$DISTSUFFIX ]; then
    curl -fkSLO $DISTFILES -o $DISTVER.$DISTSUFFIX
  fi

  # Unpack and organize
  echo "Unpacking"
  $UNPACKCOMD $DISTVER.$DISTSUFFIX
  TASK=patch
fi

package_patch 2

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
        patch -p1 < $apatch
   done

  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle

