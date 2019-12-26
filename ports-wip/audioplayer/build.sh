#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="audioplayer"
DISTSUFFIX="git"

TASK=fetch

DISTFILES="https://github.com/berryamin/$DISTVER.$DISTSUFFIX"
#UNPACKCOMD="tar -xzf"

package_init "$@"
# we must have build libevent first - see CFLAGS and LDFLAGS below
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                "
                CC=$PBTARGETARCH-gcc 
#                CFLAGS=\"-I$PWD -I$ARCHIVEDIR/$LIBEVENT_DIR/$PREFIX/include\"
#                LDFLAGS=\"-L$ARCHIVEDIR/$LIBEVENT_DIR/$PREFIX/lib\"
#                PKG_CONFIG_PATH=\"$ARCHIVEDIR/$LIBEVENT_DIR/$PREFIX/lib/pkgconfig/\"

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone --recursive $DISTFILES
  cd $DISTVER
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

