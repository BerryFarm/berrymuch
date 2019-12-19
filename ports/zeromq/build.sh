#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="zeromq-4.2.3"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://github.com/zeromq/libzmq/releases/download/v4.2.3/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
# No configure, just make
CONFIGURE_CMD="./configure --prefix=$PREFIX --host=$PBHOSTARCH CC=$PBTARGETARCH-gcc AR=$PBTARGETARCH-ar RANLIB=$PBTARGETARCH-ranlib CFLAGS=-O3"

package_fetch
package_patch
package_build

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make install DESTDIR=$DESTDIR
 	cd "$DESTDIR/$PREFIX/bin"
  TASK=bundle
fi


package_bundle

