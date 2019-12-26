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
DISTVER="tslib-1.17"
DISTSUFFIX="tar.bz2"
TASK=fetch

DISTFILES="https://github.com/kergoth/tslib/releases/download/1.17/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xjf"
package_init "$@"
CONFIGURE_CMD=" ./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
	 	--prefix=$PREFIX"

package_fetch
package_patch 
package_build
package_install
package_bundle
