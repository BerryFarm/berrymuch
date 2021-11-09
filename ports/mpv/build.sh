#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2021
#


set -e
source ../../lib.sh
DISTVER="mpv"
DISTSUFFIX="git"
GIT_TAG=v0.34.0

TASK=fetch

DISTFILES="https://github.com/mpv-player/$DISTVER.$DISTSUFFIX"
#UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure
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
  git clone $DISTFILES --depth 1 --single-branch --branch $GIT_TAG
  #cd "$WORKDIR"
  #git checkout $GIT_TAG
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

