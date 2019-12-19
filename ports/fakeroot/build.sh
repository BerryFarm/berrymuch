#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="fakeroot"
TASK=fetch

package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --with-ipc=tcp
		--program-transform-name= 
                CC=$PBTARGETARCH-gcc
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  rm -rf fakeroot
  git clone git://github.com/repos-holder/bb10-fakeroot fakeroot --depth 1
  TASK=patch
fi
package_patch
package_build
package_install
package_bundle


