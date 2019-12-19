#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="bash-5.0"
DISTSUFFIX="tar.gz"

TASK=fetch

DISTFILES="http://ftp.gnu.org/gnu/bash/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"
package_init "$@"
CONFIGURE_CMD="autoconf; ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --disable-nls 
                CC=$PBTARGETARCH-gcc 
                "
package_fetch
package_patch
package_build
package_install
package_bundle


