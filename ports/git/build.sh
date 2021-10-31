#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

BUILD_DEP_BINS=(msgfmt)
check_required_binaries

DISTVER="git-2.33.1"
DISTSUFFIX="tar.xz"
DISTFILES="https://mirrors.edge.kernel.org/pub/software/scm/git/$DISTVER.$DISTSUFFIX"

UNPACKSUFFIX="--no-same-owner"
UNPACKCOMD="tar -xJf"
PATCHLEVEL=1

TASK=fetch
package_init "$@"

CURL_DIR="curl-7.67.0"

CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                CC=$PBTARGETARCH-gcc
                CFLAGS=\"-fPIC -O3 -DNO_APPLE_COMMON_CRYPTO -DNO_D_TYPE_IN_DIRENT\"
                LDFLAGS=\"-liconv\"
                ac_cv_fread_reads_directories=no
                ac_cv_header_libintl_h=no
                ac_cv_snprintf_returns_bogus=no
		ac_cv_iconv_omits_bom=yes
                CURLDIR=\"$ARCHIVEDIR/$CURL_DIR/$PREFIX\"
                CURL_LDFLAGS=\"-lcurl\"
                CURL_CONFIG=\"$EXECDIR/curl-config.sh\"
                "

package_fetch
package_patch $PATCHLEVEL

if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"

  autoconf
  eval $CONFIGURE_CMD

  cp $EXECDIR/config.mak.uname $WORKDIR/config.mak.uname

  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
  eval $MAKE_PREFIX make

  TASK=install
fi

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make DESTDIR="$DESTDIR" NO_INSTALL_HARDLINKS=1 install
  TASK=bundle
fi

package_bundle

