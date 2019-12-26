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
              LIBUUID_DIR=\"$WORKDIR/libuuid-1.0.3/\"
              cmake \
              -DCMAKE_TOOLCHAIN_FILE=\"$EXECDIR/bb10.toolchain.cmake\" \
              -DENABLE_SYNC=OFF \
              -DCMAKE_BUILD_TYPE=release ."

              #LIBUUID_DIR=\"$ARCHIVEDIR/libuuid-1.0.3/$PREFIX\"

	      #-DCMAKE_C_FLAGS=\"-I$WORKDIR/gnutls-3.5.18/src\" \

	      #GNUTLS_CFLAGS=\"-I$WORKDIR/gnutls-3.5.18/src\" \
	      #GNUTLS_LDFLAGS=\"-L$WORKDIR/gnutls-3.5.18/lib/.libs -lgnutls\" \
	      #-DGNUTLS_CFLAGS=\"-I$WORKDIR/gnutls-3.5.18/src\" \
	      #-DGNUTLS_LDFLAGS=\"-L$WORKDIR/gnutls-3.5.18/lib/.libs -lgnutls\" \

package_fetch
package_patch
package_build
package_install
package_bundle

