#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <kaloudov@yandex.com> 2021
#

set -e
source ../../lib.sh
DISTVER="waf-2.0.22"
DISTSUFFIX="tar.bz2"

TASK=fetch

DISTFILES="https://waf.io/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xjf"
package_init "$@"
CONFIGURE_CMD=" PATH=$PATH:/root/bbndk/host_10_3_1_12/linux/x86/usr/python27/bin ./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                CC=$PBTARGETARCH-gcc 
                "
package_fetch
package_patch
package_build
package_install
package_bundle


