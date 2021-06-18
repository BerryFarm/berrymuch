#!/usr/bin/env bash

# This code Copyright 2019 LxMx Foundation
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

VER="7.16_1.1.2"
DISTVER="sc-$VER"
DISTSUFFIX="tar.gz"

DISTFILES="https://github.com/n-t-roff/sc/archive/$VER.tar.gz"
UNPACKCOMD="tar -zxf"

TASK=fetch
package_init "$@"

WORKDIR="$WORKROOT/$DISTVER"
CONFIGURE_CMD="./configure"

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  echo "Fetching sources"
  if [ ! -f $DISTVER.$DISTSUFFIX ]; then
    curl -fkSLO $DISTFILES

    # very dirty fix for cache of source archives
    ls $DISTVER.$DISTSUFFIX || ln -s $DISTFILES $DISTVER.$DISTSUFFIX

  fi

  # Unpack and organize
  echo "Unpacking"
  $UNPACKCOMD "$VER.$DISTSUFFIX"
  TASK=patch
fi

package_patch

if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"
  eval $CONFIGURE_CMD
  eval "CC=\"$PBTARGETARCH-gcc\" make"

  TASK=install
fi

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make DESTDIR="$DESTDIR" PREFIX="$PREFIX" install
  TASK=bundle
fi

package_bundle


