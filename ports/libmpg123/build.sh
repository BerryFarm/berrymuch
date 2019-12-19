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
DISTVER="libmpg123-bb10"
DISTSUFFIX="git"

TASK=fetch

DISTFILES="https://github.com/berryamin/$DISTVER.$DISTSUFFIX"
#UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure-bb10
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc 
                CFLAGS=\"-I$PWD\"
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  rm -rf fakeroot
  git clone $DISTFILES --depth 1
  cd $DISTVER
  chmod 755 ./configure-bb10 ./configure
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

