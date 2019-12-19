#!/usr/bin/env bash

set -e
source ../../lib.sh
DISTVER="libuuid-1.0.3"
DISTSUFFIX="tar.gz"  # so much for bootstrapping..
TASK=fetch

DISTFILES="https://tenet.dl.sourceforge.net/project/libuuid/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"

CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                CC=$PBTARGETARCH-gcc
                "
package_fetch
package_patch
package_build
package_install
package_bundle

