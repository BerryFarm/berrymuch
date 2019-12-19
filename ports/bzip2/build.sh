#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="bzip2-1.0.6"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://sourceware.org/pub/bzip2/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
# No configure, just make
CONFIGURE_CMD="make CC=$PBTARGETARCH-gcc AR=$PBTARGETARCH-ar RANLIB=$PBTARGETARCH-ranlib"

package_fetch
package_patch
package_build

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make install PREFIX="$DESTDIR/$PREFIX"
 	cd "$DESTDIR/$PREFIX/bin"
  ln -s -f bzgrep bzegrep
  ln -s -f bzgrep bzfgrep
  ln -s -f bzmore bzless
  ln -s -f bzdiff bzcmp
  TASK=bundle
fi


package_bundle

