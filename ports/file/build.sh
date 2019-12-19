#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="file-5.11"
DISTSUFFIX="tar.gz"
TASK=fetch

# file doesn't like to cross compile versions that differ from the 
# installed one, so our strategy will be to compile it natively first,
# then cross compile it against the native build.

# Need to auto-detect the installed version for cross compiling.
# Also add $HOME/share/misc/magic.mgc to installed .profile MAGIC

DISTFILES="ftp://ftp.astron.com/pub/file/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
package_fetch
TASK=build

CONFIGURE_CMD="./configure
                --prefix=$WORKDIR/native"

package_build
# workaround DESTDIR for the temp native install
DESTDIR_TMP=$DESTDIR
DESTDIR=/
package_install
DESTDIR=$DESTDIR_TMP
TASK=patch

CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH 
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc"
                
MAKE_PREFIX="PATH=\"$WORKDIR/native/bin:$PATH\""                

package_patch            
package_build
package_install
package_bundle
