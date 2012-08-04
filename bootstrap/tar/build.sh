#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER="tar-1.26"
DISTSUFFIX="tar.gz"  # so much for bootstrapping..
DISTFILES="http://ftp.gnu.org/gnu/tar/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$DESTDIR 
                --disable-nls 
                CC=$PBTARGETARCH-gcc 
                LIBS=-lsocket
                "
package_init "$@"
package_fetch
package_patch
package_build
package_install
package_bundle


