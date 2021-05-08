#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
#
# thanks to extrowerk for the "Dirty patchset for BBOS10"
#


set -e
set -x
source ../../lib.sh
DISTVER="netbsd-curses"
DISTSUFFIX="git"
TASK=fetch

DISTFILES="https://github.com/berryfarm/$DISTVER.$DISTSUFFIX"
GITTAG=BBOS10_hack

#CONFIGURE_CMD=""
MYMAKEFLAGS="   CC=$PBTARGETARCH-gcc 
		CPPFLAGS=\"-I. -Ilibterminfo\"
		"

MAKEPREFIX=$PREFIX

package_init "$@"
# No configure, just make

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  git clone $DISTFILES --depth 1 --branch $GITTAG

  TASK=build
fi

#package_patch 1

package_build

package_install

package_bundle

