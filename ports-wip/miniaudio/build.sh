#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER=miniaudio

GIT_REPO="https://github.com/dr-soft/$DISTVER.git"
GIT_OPTS="--depth 1"
GIT_VER=master


package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --disable-nls 
                CC=$PBTARGETARCH-gcc
                MAKEINFO='/usr/bin/makeinfo --force'
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone $GIT_REPO $GIT_OPTS
  cd $DISTVER
  git checkout $GIT_VER
  cd "$WORKDIR"
  TASK=patch
fi
package_patch
package_build
package_install
package_bundle
