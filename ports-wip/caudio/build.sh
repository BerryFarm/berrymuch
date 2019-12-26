#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="cAudio"
DISTSUFFIX="git"
DISTFILES="https://github.com/berryamin/cAudio.git"
GITVER=""
UNPACKCOMD="tar -xzf"
OPENAL_PREFIX_PATH=

TASK=fetch
package_init "$@"
CONFIGURE_CMD="cmake ."

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone --recursive $DISTFILES
  cd $DISTVER
  #git checkout $GITVER
  cd "$WORKDIR"
  TASK=patch
fi
package_patch
package_build
package_install
package_bundle

