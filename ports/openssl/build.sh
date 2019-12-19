#!/usr/bin/env bash

set -x

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018
#


set -e
source ../../lib.sh
DISTVER="openssl-1.0.2t"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://www.openssl.org/source/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="
		./Configure -DNO_SYSLOG -lsocket
                --prefix=$PREFIX
		QNX6 os/compiler:arm-unknown-nto-qnx8.0.0eabi-gcc
                "
package_fetch
package_patch
package_build


if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make INSTALL_PREFIX=$DESTDIR install
        cd "$DESTDIR/$PREFIX/bin"
  TASK=bundle
fi


#package_install
package_bundle
