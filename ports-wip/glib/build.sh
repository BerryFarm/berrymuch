#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <kaloudov@yandex.com>, 2021
#


set -e
source ../../lib.sh
DISTVER="glib"
DISTSUFFIX="git"
TASK=fetch

DISTFILES="https://github.com/GNOME/$DISTVER.$DISTSUFFIX"

#CONFIGURE_CMD=""
MYMAKEFLAGS="   CC=$PBTARGETARCH-gcc 
		CPPFLAGS=\"-I. -Iinclude\"
		"

package_init "$@"
# No configure, just make

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  git clone $DISTFILES --depth 1 --single-branch --branch GLIB_1_2_8

  TASK=patch
fi

if [ "$TASK" == "patch" ]
then
  	cd "$WORKDIR"
	sh ./autogen.sh	
	automake
	autoconf
fi

#package_patch 1
package_build
package_install
package_bundle

