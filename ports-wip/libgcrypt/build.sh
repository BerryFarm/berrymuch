#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="libgcrypt"
DISTSUFFIX="git"
GITVER="libgcrypt-1.8.3"
TASK=fetch

package_init "$@"
CONFIGURE_CMD="./autogen.sh ;
		./configure --enable-maintainer-mode
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		--disable-doc
                CC=$PBTARGETARCH-gcc
		CFLAGS=\"-I../libgpg-error-1.32/src -I../../libgpg-error-1.32/src -fPIC -DENABLE_NEON_SUPPORT\"
		LDFLAGS=\" -lgpg-error -lsocket -L/Users/testuser/bb/playbook-dev-tools/work/libgpg-error-1.32/src/.libs\"
                MAKEINFO='/usr/bin/makeinfo --force'
                "

MYMAKEFLAGS=\"CC_FOR_BUILD=gcc\"

# Flag not recognized
#--with-libgpg-error-prefix=../libgpg-error-1.32

# FIXME
#  Absolute path in LDFLAGS was used due to an issue with libtool "not able to detect absolute path"
#  We should use something like this instead
#-L../libgpg-error-1.32/src/.libs

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone --recursive https://github.com/gpg/libgcrypt.git $DISTVER
  cd $DISTVER
  git checkout $GITVER
  cd "$WORKDIR"
  TASK=patch
fi
package_patch 1
package_build
package_install
package_bundle


