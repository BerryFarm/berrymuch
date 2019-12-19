#!/usr/bin/env bash

set -e
source ../../lib.sh
DISTVER="task-2.4.2"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://taskwarrior.org/download/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"

# we must have build libuuid first - see LIBUUID_DIR below
CONFIGURE_CMD="PBTARGETARCH=\"$PBTARGETARCH\"
              PREFIX=\"$PREFIX\"
              QNX_TARGET=\"$QNX_TARGET\"
              LIBUUID_DIR=\"$ARCHIVEDIR/libuuid-1.0.3/$PREFIX\"
              cmake \
              -DCMAKE_TOOLCHAIN_FILE=\"$EXECDIR/bb10.toolchain.cmake\" \
              -DCMAKE_INSTALL_PREFIX=\"$PREFIX\" \
              -DENABLE_SYNC=OFF \
              -DCMAKE_BUILD_TYPE=release ."

package_fetch
package_patch
package_build
package_install
package_bundle

