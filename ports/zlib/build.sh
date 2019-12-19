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
DISTVER="zlib-1.2.11"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://zlib.net/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="
		CC=arm-unknown-nto-qnx8.0.0eabi-gcc
		AR=arm-unknown-nto-qnx8.0.0eabi-ar
		LD=arm-unknown-nto-qnx8.0.0eabi-ld
		./configure 
                --prefix=$PREFIX 
                "

#MYMAKEFLAGS='CC=arm-unknown-nto-qnx8.0.0eabi-gcc AR=arm-unknown-nto-qnx8.0.0eabi-ar LD=arm-unknown-nto-qnx8.0.0eabi-ld'


package_fetch
package_patch 1
package_build
package_install
package_bundle

