#!/usr/bin/env bash -x

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="syncthing"
DISTSUFFIX="git"
GIT_URL="https://github.com/syncthing/syncthing.git"

#
# This binary should be present in one of the host dirs in PATH
# Currently no function uses this variable,
# but it's planned to implement "check_binaries <list of binaries>"
#
REQUIRED_BIN="go" 
TASK=fetch

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

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version if not downloaded until the end
  [ -f $DISTVER/.download_completed ] || {
  	rm -rf "$DISTVER"
  	git clone --recursive $GIT_URL $DISTVER
	touch $DISTVER/.download_completed
  }
  cd $DISTVER
  #rm configure
  ./build.sh
  #git checkout $TG_GITVER
  cd "$WORKDIR"
  TASK=patch
fi
package_patch
package_build
package_install
package_bundle


