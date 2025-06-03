#!/bin/bash
set -e

# Load common functions and variables (ensure this exists)
source ../../lib.sh

TASK=fetch

PKGNAME="pforth"
VER="2.0.1"
DISTVER="v$VER"
DISTSUFFIX="tar.gz"

# Official pforth tarball URL
DISTFILES="https://github.com/philburk/pforth/archive/refs/tags/v$VER.$DISTSUFFIX"
UNPACKCOMD="tar -zxf"

package_init "$@"

CONFIGURE_CMD=""

WORKDIR="$WORKDIR/../pforth-$VER"

package_fetch
package_patch

if [ "$TASK" == "build" ]; then
  echo "Building pforth..."

  cd "$WORKDIR/platforms/unix"

  # If cross-compiling, set CC, otherwise use default
  if [ -n "$PBTARGETARCH" ]; then
    MYMAKEFLAGS="CC=${PBTARGETARCH}-gcc"
  else
    MYMAKEFLAGS=""
  fi

  eval make $MYMAKEFLAGS

  TASK=install
fi

if [ "$TASK" == "install" ]; then
  mkdir -p "$DESTDIR/$PREFIX/bin"
  # The built binary is 'pforth_standalone'
  cp "$WORKDIR/platforms/unix/pforth_standalone" "$DESTDIR/$PREFIX/bin/pforth"
  TASK=bundle
fi

package_bundle
