#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="pkgsrc-2018Q1"
DISTSUFFIX="tar.bz2"
TASK=fetch


DISTFILES="http://cdn.netbsd.org/pub/pkgsrc/stable/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xjf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD=" ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		CFLAGS=\"-O3\"
                "
#--vim_cv_touper_broken=no
package_fetch
package_patch

if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKROOT/$DISTVER"
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

