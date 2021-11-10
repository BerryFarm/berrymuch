#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2021
#


set -ex
source ../../lib.sh
DISTVER="mpv"
DISTSUFFIX="git"
#GIT_TAG=v0.34.0
GIT_TAG=9628edede001e7af0dcf487a3d27d909ad4e87e3~1
ZLIB_DIR=zlib-1.2.11
LIBFFMPEG_DIR="ffmpeg-4.2.2"


TASK=build
#TASK=fetch

DISTFILES="https://github.com/mpv-player/$DISTVER.$DISTSUFFIX"
#UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD=" ./TOOLS/old-configure 
		--cc=$PBTARGETARCH-gcc 
  		--extra-cflags=\"-I$PWD  -I$ARCHIVEDIR/$ZLIB_DIR/$PREFIX/include -I$ARCHIVEDIR/$LIBFFMPEG_DIR/$PREFIX/include\"
  		--extra-libs=\" -lz -liconv \" 
  		--extra-ldflags=\"-L$ARCHIVEDIR/$LIBFFMPEG_DIR/$PREFIX/lib\"
		--disable-libass 
		--disable-ffmpeg 
                --prefix=$PREFIX "


if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  git clone $DISTFILES --single-branch --branch master
  cd "$WORKDIR"
  git checkout $GIT_TAG
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

