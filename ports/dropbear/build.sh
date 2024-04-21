#!/usr/bin/env bash

# This code Copyright 2020 LxMx Foundation
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="dropbear-2022.83"
DISTSUFFIX="tar.bz2"
TASK=fetch

DISTFILES="https://matt.ucc.asn.au/dropbear/releases/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                --disable-syslog
                --disable-lastlog
                CC=$PBTARGETARCH-gcc
                LIBS=-lsocket
                "

package_fetch
package_patch
package_build
package_install

package_bundle


