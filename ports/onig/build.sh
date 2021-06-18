#!/usr/bin/env bash

# This code Copyright 2019 LxMx Foundation
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh

VER="6.9.4"
DISTVER="onig-$VER"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://github.com/kkos/oniguruma/releases/download/v$VER/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                CC=$PBTARGETARCH-gcc"

package_fetch
package_patch
package_build
package_install
package_bundle

