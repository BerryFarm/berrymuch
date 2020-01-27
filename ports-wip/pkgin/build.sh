#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018
#

set -e
source ../../lib.sh
DISTVER="pkgin"
DISTSUFFIX="git"
TASK=fetch

DISTFILES="https://github.com/NetBSDfr/$DISTVER.$DISTSUFFIX"
#UNPACKCOMD="tar -xJf"

LIBFETCH_DIR="libfetch-xbps-2.0"
OPENSSL_DIR="openssl-1.0.2t"

package_init "$@"

CONFIGURE_CMD=" ./configure
                CFLAGS=\"-I$ARCHIVEDIR/$LIBFETCH_DIR/$PREFIX/include -I$ARCHIVEDIR/$OPENSSL_DIR/$PREFIX/include\"
                LDFLAGS=\"-L$ARCHIVEDIR/$LIBFETCH_DIR/$PREFIX/lib -L$ARCHIVEDIR/$OPENSSL_DIR/$PREFIX/lib\"
                LIBS=\"-lsocket -lssl -lcrypto\"
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX"

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone $DISTFILES
  TASK=patch
fi


if [ "$TASK" == "build" ]
then
  cd "$WORKROOT/$DISTVER"
  scons
  TASK=install
fi


package_fetch
package_patch 1
package_build
package_install
package_bundle

