#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER="lua-5.3.6"
DISTSUFFIX="tar.gz"
DISTFILES="https://www.lua.org/ftp/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"

CONFIGURE_CMD=""
MYMAKEFLAGS="posix"

package_fetch
package_patch 
package_build

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make INSTALL_TOP="$DESTDIR/$PREFIX" install
  TASK=bundle
fi

package_bundle
