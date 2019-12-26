#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

VER="0.7.0"
DISTVER="v$VER"
DISTSUFFIX="tar.gz"

DISTFILES="https://github.com/andmarti1424/sc-im/archive/v$VER.$DISTSUFFIX"
UNPACKCOMD="tar -zxf"

package_init "$@"
CONFIGURE_CMD=""
WORKDIR="$WORKDIR/../sc-im-$VER"

package_fetch
package_patch

if [ "$TASK" == "build" ]
then
  echo "Building"

  cd "$WORKDIR/src"

  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make

  TASK=install
fi

if [ "$TASK" == "install" ]
then
  mkdir -p "$DESTDIR/$PREFIX/"{bin,lib,man}
  mkdir -p "$DESTDIR/$PREFIX/man/man1"

  cd "$WORKDIR/src"
  make DESTDIR="$DESTDIR" PREFIX="$PREFIX" install
  TASK=bundle
fi

package_bundle
