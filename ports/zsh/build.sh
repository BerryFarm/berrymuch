#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Carlos Perez-Guerra


set -e
source ../../lib.sh
DISTVER="zsh-5.9"
DISTSUFFIX="tar.xz"

TASK=fetch

DISTFILES="http://www.zsh.org/pub/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"
package_init "$@"
CONFIGURE_CMD="autoconf; ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc 
                "
package_fetch
package_patch 1
package_build
package_install
package_bundle


