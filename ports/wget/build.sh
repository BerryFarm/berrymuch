#!/usr/bin/env bash

# This code Copyright 2019 LxMx Foundation
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="wget-1.21.4"
DISTSUFFIX="tar.lz"
TASK=fetch

DISTFILES="https://ftp.gnu.org/gnu/wget/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"
package_init "$@"

OPENSSL_DIR="openssl-1.0.2u"

CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                --disable-nls
                --with-ssl=openssl
                OPENSSL_CFLAGS=\"-I$ARCHIVEDIR/$OPENSSL_DIR/$PREFIX/include\"
                OPENSSL_LIBS=\"-L$ARCHIVEDIR/$OPENSSL_DIR/$PREFIX/lib -lssl -lcrypto\"
                CC=$PBTARGETARCH-gcc
                "
package_fetch
package_patch
package_build
package_install
package_bundle

