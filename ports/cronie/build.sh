#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER="cronie-1.5.2"
DISTSUFFIX="tar.gz"
DISTFILES="https://github.com/cronie-crond/cronie/releases/download/cronie-1.5.2/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="./configure 
		CFLAGS=\"-fPIC\"
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
                "

package_fetch
package_patch 2
package_build
package_install
package_bundle
