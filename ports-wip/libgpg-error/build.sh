#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="libgpg-error-1.32"
DISTSUFFIX="tar.gz"
DISTFILES="ftp://ftp.gnupg.org/gcrypt/libgpg-error/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
#PATH=$PATH:/usr/local/Cellar/gettext/0.19.4/bin

BUILD_DEP_BINS=(gettext)   # be carefull, bash array syntax is separated by spaces
check_required_binaries

TASK=fetch

package_init "$@"
CONFIGURE_CMD="./autogen.sh ;
		./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
                MAKEINFO='/usr/bin/makeinfo --force'
                "

package_fetch
package_patch 1
package_build
package_install
package_bundle


