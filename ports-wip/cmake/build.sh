#!/usr/bin/env bash

set -e
source ../../lib.sh
source ./vars.sh
TASK=fetch

DISTFILES="https://cmake.org/files/v3.9/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"

# we must have build libuuid first - see LIBUUID_DIR below
CONFIGURE_CMD="PBTARGETARCH=\"$PBTARGETARCH\"
              PREFIX=\"$PREFIX\"
              QNX_TARGET=\"$QNX_TARGET\"
              cmake \
              -DCMAKE_TOOLCHAIN_FILE=\"$EXECDIR/bb10.toolchain.cmake\" \
              -DCMAKE_BUILD_TYPE=release ."

package_fetch
package_patch
package_build
package_install
package_bundle

