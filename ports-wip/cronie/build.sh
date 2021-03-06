#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER="cronie-1.5.5"
DISTSUFFIX="tar.gz"
DISTFILES="https://github.com/cronie-crond/cronie/releases/download/cronie-1.5.5/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="./configure
		CFLAGS=\"-fPIC -g -ggdb -fvar-tracking\"
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
		--localstatedir=/var/tmp
		--disable-anacron
                CC=$PBTARGETARCH-gcc
                "

package_fetch
package_patch 2
package_build
package_install
package_bundle
