#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="ed-1.15"
DISTSUFFIX="tar.lz"
TASK=fetch

DISTFILES="https://ftp.gnu.org/gnu/ed/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

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
package_build
package_install

package_bundle


