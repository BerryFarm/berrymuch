#!/usr/bin/env bash

# This code Copyright 2019 LxMx Foundation
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh

VER="1.19.0"
DISTVER="ansiweather-$VER"
DISTSUFFIX="tar.gz"

TASK=fetch

DISTFILES="https://github.com/fcambus/ansiweather/releases/download/$VER/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"
package_fetch

if [ "$TASK" == "patch" ]
then
  TASK=install
fi

if [ "$TASK" == "install" ]
then
  BINDIR="$DESTDIR/$PREFIX/bin"
  mkdir -p "$BINDIR"

  cp "$WORKDIR/ansiweather" "$BINDIR"
  TASK=bundle
fi

package_bundle

