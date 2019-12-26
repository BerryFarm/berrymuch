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
DISTVER="SDL2-2.0.8"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://www.libsdl.org/release/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD=" ./configure
		--enable-video-x11=no
		--enable-input-tslib=yes
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
	 	--prefix=$PREFIX"

#CFLAGS=\"-ITouchControlOverlay/public -O3\"

package_fetch
package_patch 1
package_build
package_install
package_bundle
