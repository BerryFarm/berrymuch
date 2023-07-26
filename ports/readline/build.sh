#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="readline-8.1"
DISTSUFFIX="tar.gz"
TASK=fetch


DISTFILES="http://ftp.gnu.org/gnu/readline/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --disable-nls 
                --enable-threads=posix 
                CC=$PBTARGETARCH-gcc
                "

package_fetch
package_patch
package_build
package_install
package_bundle

