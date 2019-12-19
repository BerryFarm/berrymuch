#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="bison-2.5.1"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="http://ftp.gnu.org/gnu/bison/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --enable-threads=posix 
                --disable-nls 
                CC=$PBTARGETARCH-gcc"

package_fetch
package_patch
package_build
package_install

# remove the absolute path from the yacc wrapper
sed -i='' 's/'\''.*bison'\''/'\''bison'\''/'  "$DESTDIR/$PREFIX/bin/yacc"
if [ -e "$DESTDIR/$PREFIX/bin/yacc=" ]; then
  # clean up after sed backup file
  rm "$DESTDIR/$PREFIX/bin/yacc="
fi

package_bundle


