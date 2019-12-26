#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <kaloudov@yandex.ru>, 2019

set -e
source ../../lib.sh
TASK=fetch

DISTVER="rockbox"
DISTSUFFIX="git"
GIT_VER="v3.14-final"

DISTFILES="https://github.com/Rockbox/$DISTVER.$DISTSUFFIX"

package_init "$@"
# we must have build libevent first - see CFLAGS and LDFLAGS below
CONFIGURE_CMD="../tools/configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=sdlapp
                --prefix=$PREFIX 
		--lcdwidth=800
		--lcdheight=480
		--type=N
                CC=$PBTARGETARCH-gcc 
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  [ -d $DISTVER ] || git clone --recursive $DISTFILES $DISTVER --depth 1
  cd $DISTVER
  git fetch origin refs/tags/$GIT_VER:refs/tags/$GIT_VER
  git checkout $GIT_VER
  rm -rf build
  mkdir build
  cd build
  #cd "$WORKDIR"
  echo "DEBUG: pwd=$(pwd)"
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

