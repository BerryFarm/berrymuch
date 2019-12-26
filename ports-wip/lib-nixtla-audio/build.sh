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
DISTVER="lib-nixtla-audio"
DISTSUFFIX="git"
TASK=fetch

DISTFILES="https://github.com/berryamin/$DISTVER.$DISTSUFFIX"
MYMAKEFLAGS="CC=$PBTARGETARCH-gcc"

package_init "$@"
# No configure, just make

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  rm -rf fakeroot
  git clone $DISTFILES
  cd lib-nixtla-audio
  git checkout bb10
  TASK=build
fi

#package_patch
package_build
package_install
package_bundle

