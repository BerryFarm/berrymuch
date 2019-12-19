#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="sqlite-autoconf-3240000"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://sqlite.org/2018/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="LIBUUID_DIR=\"$ARCHIVEDIR/libuuid-1.0.3/$PREFIX\"
		./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc 
		CFLAGS=-O3
                "
package_fetch
package_patch
package_build
package_install
package_bundle


