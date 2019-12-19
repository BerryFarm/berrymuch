#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="tmux-1.9a"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://github.com/tmux/tmux/releases/download/1.9a/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
LIBEVENT_DIR="libevent-2.0.22-stable"

package_init "$@"
# we must have build libevent first - see CFLAGS and LDFLAGS below
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --enable-static
                CC=$PBTARGETARCH-gcc 
                CFLAGS=\"-I$PWD -I$ARCHIVEDIR/$LIBEVENT_DIR/$PREFIX/include\"
                LDFLAGS=\"-L$ARCHIVEDIR/$LIBEVENT_DIR/$PREFIX/lib\"
                PKG_CONFIG_PATH=\"$ARCHIVEDIR/$LIBEVENT_DIR/$PREFIX/lib/pkgconfig/\"
                LIBEVENT_LIBS=\"-levent -lsocket\"
                "

package_fetch
package_patch
package_build
package_install
package_bundle

