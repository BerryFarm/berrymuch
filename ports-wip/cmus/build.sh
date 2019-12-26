#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018
#

#
# Note: this build is being put on hold, cause it needs GCC-4.9 at least for Atomic operations
# gcc 4.8.1 and newer already support Atomic operations .. So we should be able to compile !
# https://gcc.gnu.org/gcc-4.8/cxx0x_status.html
# 
# stdatomic.h is missing in 4.8.3, maybe we should just copy/paste it from 4.9
# https://stackoverflow.com/questions/20326604/stdatomic-h-in-gcc-4-8
#

set -e
source ../../lib.sh


DISTVER="cmus"
DISTSUFFIX="git"
DISTFILES="https://github.com/$DISTVER/$DISTVER.git"
GITVER="v2.8.0-rc0"
UNPACKCOMD="tar -xJf"
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure 
                CC=\"arm-unknown-nto-qnx8.0.0eabi-gcc-4.8.3\"
                AR=\"arm-unknown-nto-qnx8.0.0eabi-gcc-ar-4.8.3\"
                CPP=\"arm-unknown-nto-qnx8.0.0eabi-cpp-4.8.3\"
                CXX=\"arm-unknown-nto-qnx8.0.0eabi-g++-4.8.3\"
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
  git clone --recursive $DISTFILES $DISTVER
  cd $DISTVER
  git checkout $GITVER
  cd "$WORKDIR"
  TASK=patch
fi

package_patch
package_build
package_install
package_bundle

