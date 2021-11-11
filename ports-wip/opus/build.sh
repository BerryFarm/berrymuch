#!/usr/bin/env bash 

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2021
#


set -e
source ../../lib.sh
DISTVER="opus-1.3.1"
DISTSUFFIX="tar.gz"

TASK=fetch

DISTFILES="https://archive.mozilla.org/pub/opus/$DISTVER.$DISTSUFFIX"
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

