#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="rsync-3.1.3"
DISTSUFFIX="tar.gz"
TASK=fetch


DISTFILES="https://download.samba.org/pub/rsync/src/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                CC=$PBTARGETARCH-gcc
		CFLAGS=-O3
                "

package_fetch
package_patch
package_build
package_install
package_bundle

