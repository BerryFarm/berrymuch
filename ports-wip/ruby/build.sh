#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.



set -e
source ../../lib.sh
DISTVER="ruby-1.8.7-p371"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTVER="ruby-2.5.1"
DISTSUFFIX="tar.gz"
DEPENDS="libevent"
BUILD_DEP_BINS=()
#check_required_binaries

DISTFILES="https://cache.ruby-lang.org/pub/ruby/2.5/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
PATCHLEVEL=1
TASK=fetch
package_init "$@"
CONFIGURE_CMD="autoconf; ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
		CFLAGS=\"-fPIC -I../unpacked/include/event\"
		LDFLAGS=\"-L../unpacked/lib -lsocket -levent2\"
                "

package_fetch
#package_patch $PATCHLEVEL

TASK=build
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
  autoconf
  eval $CONFIGURE_CMD
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle

