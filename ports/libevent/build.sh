#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="libevent-2.0.22-stable"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc 
                CFLAGS=\"-I$PWD\"
                "

package_fetch
package_patch
package_build
package_install
package_bundle

