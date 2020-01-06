#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="calcurse-4.5.1"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="http://calcurse.org/files/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                --disable-nls
                CC=$PBTARGETARCH-gcc"

package_fetch
package_patch

cp $EXECDIR/*.h $WORKDIR/src
cp $EXECDIR/*.c $WORKDIR/src

package_build
package_install

package_bundle


