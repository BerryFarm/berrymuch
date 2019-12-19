#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="coreutils-8.29"
DISTSUFFIX="tar.xz"
TASK=fetch

DISTFILES="http://ftp.gnu.org/gnu/coreutils/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf "

package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --enable-threads=posix 
                --disable-nls 
                --enable-no-install-program=mknod,stat,uname,cut
                CC=$PBTARGETARCH-gcc 
                "
package_fetch
package_patch
package_build
package_install
package_bundle

