#!/usr/bin/env bash -x

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="seafile"
DISTSUFFIX="git"
TASK=fetch

#SEAFILE_GITVER=6547c0b21b977b327b3c5e8142963f4bc246187a

package_init "$@"
CONFIGURE_CMD=" ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		CFLAGS=\"-I.\"
		LDFLAGS=\"-L.\"
                CC=$PBTARGETARCH-gcc
                "
		#--without-zlib

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version if not downloaded until the end
  [ -f $DISTVER/.download_completed ] || {
  	rm -rf "$DISTVER"
  	git clone --recursive https://github.com/haiwen/seafile $DISTVER
	touch $DISTVER/.download_completed
  }
  cd $DISTVER
  #rm configure
  ./autogen.sh
  #git checkout $TG_GITVER
  cd "$WORKDIR"
  TASK=patch
fi
package_patch
package_build
package_install
package_bundle


