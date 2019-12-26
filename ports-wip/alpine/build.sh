#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

BUILD_DEP_BINS=(aclocal automake autoconf)
check_required_binaries

DISTVER="alpine"
DISTSUFFIX="git"
GITVER="master"
TASK=fetch

package_init "$@"
CONFIGURE_CMD=" aclocal; automake ; autoconf;
		 ./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
		CFLAGS=\"-I/tmp/tmp -I/Applications/Momentics.app/target_10_3_1_995/qnx6/usr/include/openssl\"
		LDFLAGS=\"\"
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone --recursive http://repo.or.cz/alpine.git
  cd $DISTVER
  git checkout $GITVER
  cd "$WORKDIR"
  TASK=patch
fi
package_patch 1
package_build
package_install
package_bundle


