#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <kaloudov@yandex.com>, 2021
#


set -ex
source ../../lib.sh
DISTVER="figlet-2.2.5"
DISTSUFFIX="tar.gz"
TASK=fetch


DISTFILES="ftp://ftp.figlet.org/pub/figlet/program/unix/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD=" CC=$PBTARGETARCH-gcc make
                "

package_fetch
package_patch
package_build
package_install
package_bundle

