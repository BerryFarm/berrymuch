#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018
#


set -e
source ../../lib.sh
DISTVER="cflow-1.5"
DISTSUFFIX="tar.xz"
TASK=fetch


DISTFILES="http://ftp.gnu.org/gnu/cflow/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"
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

