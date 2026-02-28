#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#


set -e
set -x
source ../../lib.sh
DISTVER="nnn"
DISTSUFFIX="git"
TASK=fetch

DISTFILES="https://github.com/jarun/$DISTVER.$DISTSUFFIX"
GITTAG=v4.9

#CONFIGURE_CMD=""
MYMAKEFLAGS="   CC=$PBTARGETARCH-gcc 
                CPPFLAGS=\"-I. -Iinclude\" \
                "

MAKEPREFIX=$PREFIX

package_init "$@"
# No configure, just make

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  git clone $DISTFILES --depth 1
  cd $DISTVER
  git fetch --tags
  git checkout $GITTAG

  TASK=patch
fi

package_patch 1
package_build

package_install

package_bundle
