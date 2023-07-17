#!/usr/bin/env bash

# This code Copyright 2019 LxMx Foundation
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="ircii-20210314"
DISTSUFFIX="tar.bz2"
TASK=fetch

DISTFILES="http://ircii.warped.com/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -jxf"

package_init "$@"

CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                LIBS=-lsocket
                CC=$PBTARGETARCH-gcc
                "
package_fetch
package_patch
package_build
package_install
package_bundle

