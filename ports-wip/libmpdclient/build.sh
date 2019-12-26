#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="libmpdclient-2.15"
DISTSUFFIX="tar.xz"
TASK=fetch

BUILD_DEP_BINS=(ninja glibtoolize doxygen)   # be carefull, bash array syntax is separated by spaces
check_required_binaries 

DISTFILES="http://www.musicpd.org/download/libmpdclient/2/libmpdclient-2.15.tar.xz"
UNPACKCOMD="tar -xJf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="chmod 755 *sh configure; ./autogen.sh; ./configure
		--enable-shared 
		--enable-static 
		--disable-documentation
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
		CFLAGS=\"-O2 -pipe\"
		CXXFLAGS=\"-O2 -pipe -fno-exceptions -fno-rtti\"
                "

package_fetch
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
  eval $CONFIGURE_CMD

  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle

