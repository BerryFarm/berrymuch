#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="bc-1.07"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://ftp.gnu.org/gnu/bc/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                --disable-nls
                --with-readline
                CC=$PBTARGETARCH-gcc"

package_fetch
package_patch

cp $EXECDIR/libmath.h $WORKDIR/bc/libmath.h

package_build
package_install
package_bundle


