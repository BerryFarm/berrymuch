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
TASK=fetch

DISTVER="mosh"
DISTSUFFIX="git"
DISTFILES="https://github.com/berryamin/$DISTVER.$DISTSUFFIX"
#UNPACKCOMD="tar -xJf"
package_init "$@"
CONFIGURE_CMD=" ./autogen.sh ; 
		./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
	 	--prefix=$PREFIX"
		CFLAGS=\"-I$PWD -I$WORKROOT/protobuf/src/google/protobuf\"
		LDFLAGS=\"-lprotobuf -L$WORKROOT/protobuf/src/google/protobuf\"

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone $DISTFILES
  TASK=patch
fi


package_fetch
package_patch 1
package_build
package_install
package_bundle
