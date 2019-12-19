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
DISTVER="jansson-2.11"
DISTSUFFIX="tar.gz"  # so much for bootstrapping..
TASK=fetch

DISTFILES="http://www.digip.org/jansson/releases/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --disable-nls 
                CC=$PBTARGETARCH-gcc 
		CFLAGS=-O3
                "
package_fetch
package_patch
package_build
package_install
package_bundle


