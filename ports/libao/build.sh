#!/usr/bin/env bash

set -x

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018
#


set -e
source ../../lib.sh
DISTVER="libao-1.2.0"
DISTSUFFIX="tar.gz"
TASK=fetch


DISTFILES="http://downloads.xiph.org/releases/ao/libao-1.2.0.tar.gz"
UNPACKCOMD="tar -xzf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		CC=\"arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3\"
		AR=\"arm-unknown-nto-qnx8.0.0eabi-gcc-ar-4.6.3\"
		CPP=\"arm-unknown-nto-qnx8.0.0eabi-cpp-4.6.3\"
		CXX=\"arm-unknown-nto-qnx8.0.0eabi-g++-4.6.3\"
		CFLAGS=\"-O3\"
		LDFLAGS=\"-O3 -lasound\"
                "
if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  echo "Fetching sources"
  if [ ! -f $DISTVER.$DISTSUFFIX ]; then
    curl -fkSLO $DISTFILES -o $DISTVER.$DISTSUFFIX
  fi

  # Unpack and organize
  echo "Unpacking"
  $UNPACKCOMD $DISTVER.$DISTSUFFIX
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

