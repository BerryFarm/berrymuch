#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="curl-7.51.0"
DISTSUFFIX="tar.bz2"  # so much for bootstrapping..
TASK=fetch

DISTFILES="https://curl.haxx.se/download/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --disable-nls 
                CC=$PBTARGETARCH-gcc 
                LIBS=-lsocket
                "
package_fetch
package_patch
package_build
package_install
package_bundle


