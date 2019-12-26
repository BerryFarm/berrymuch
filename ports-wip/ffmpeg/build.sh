#!/usr/bin/env bash

set -x

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e
source ../../lib.sh
DISTVER="ffmpeg-3.4.2"
DISTSUFFIX="tar.bz2"
TASK=fetch

DISTFILES="https://ffmpeg.org/releases/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xjf"

package_fetch
package_init "$@"

# to enable h.264 support add `--enable-gpl --enable-libx264 --extra-cflags=-I/workspace/libffbb/libx264/include --extra-ldflags=-L/workspace/libffbb/libx264/lib/armle-v7`
CONFIGURE_CMD="./configure --enable-cross-compile --cross-prefix=arm-unknown-nto-qnx8.0.0eabi- --arch=armv7 --disable-debug --enable-optimizations --enable-asm --disable-static --enable-shared --target-os=qnx --disable-ffplay --disable-ffserver --disable-ffprobe --prefix=$PREFIX"

package_patch
package_build
package_install
package_bundle

