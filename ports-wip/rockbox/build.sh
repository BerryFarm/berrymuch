#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <kaloudov@yandex.ru>, 2019

set -ex
source ../../lib.sh
TASK=fetch

DISTVER="rockbox"
DISTSUFFIX="git"
GIT_VER="v3.15-final"

DISTFILES="https://github.com/Rockbox/$DISTVER.$DISTSUFFIX"

package_init "$@"
# we must have build libevent first - see CFLAGS and LDFLAGS below
#CONFIGURE_CMD="cd build ; ../tools/configure 
CONFIGURE_CMD="cd build ; PATH=$PATH:$WORKDIR ../tools/rockboxdev.sh
                --prefix=$PREFIX 
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  git clone --recursive $DISTFILES $DISTVER --depth 1 --single-branch --branch $GIT_VER
  cp $EXECDIR/libtool $WORKDIR
  mkdir "$WORKDIR/build"
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

