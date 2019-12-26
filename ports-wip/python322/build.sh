#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="Python"
#GITTAG="v1.43"
DISTSUFFIX="git"
DISTFILES="https://github.com/blackberry/$DISTVER.$DISTSUFFIX"

#BUILD_DEP_BINS=()
#check_required_binaries

TASK=fetch
package_init "$@"
CONFIGURE_CMD=" ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc
                "


if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  #rm -rf "$DISTVER"
  git clone $DISTFILES $DISTVER
  cd $DISTVER
  #git checkout $GITTAG
  TASK=patch
fi

package_patch 1

if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"
  mv Python-3/* .
  rm -rf Python-3

  for apatch in $EXECDIR/post-conf-patches/*
   do
        patch -p0 < $apatch
   done

  eval $CONFIGURE_CMD
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle
