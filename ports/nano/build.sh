#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2024
#


set -e
source ../../lib.sh
DISTVER="nano-4.5"
DISTSUFFIX="tar.xz"
TASK=fetch

DISTFILES="https://mirror.ibcp.fr/pub/gnu/nano/$DISTVER.$DISTSUFFIX"
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
package_patch 1
TASK=build
package_build
package_install
package_bundle

