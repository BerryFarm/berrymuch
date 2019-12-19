#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="groff-1.22.3"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="http://ftp.gnu.org/gnu/groff/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --without-x 
                --without-gs
                --with-doc=no
                "

package_fetch
package_patch 1
package_build
package_install
package_bundle

