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
DISTVER="gdb-7.12"
DISTSUFFIX="tar.xz"
TASK=fetch

DISTFILES="http://ftp.gnu.org/gnu/gdb/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"
package_init "$@"
CONFIGURE_CMD="./configure --prefix=$PREFIX"


if [ "$TASK" == "build" ]
then
  cd "$WORKROOT/$DISTVER"
  scons
  TASK=install
fi


package_fetch
package_patch 1
package_build
package_install
package_bundle

