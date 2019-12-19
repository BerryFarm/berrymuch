#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER="git-2.12.5"
DISTSUFFIX="tar.xz"
BUILD_DEP_BINS=(msgfmt)
check_required_binaries

DISTFILES="https://mirrors.edge.kernel.org/pub/software/scm/git/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"
PATCHLEVEL=1
TASK=fetch
package_init "$@"
CONFIGURE_CMD="./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                CC=$PBTARGETARCH-gcc
		CFLAGS=\"-fPIC -O3 -DNO_APPLE_COMMON_CRYPTO -DNO_GETTEXT -DSA_RESTART=0 -DNO_D_TYPE_IN_DIRENT\"
		LDFLAGS=-liconv
                "
		#--without-iconv

package_fetch
package_patch $PATCHLEVEL
if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"
  # clean up if we have a previous build
  #if [ -e "Makefile" ]; then
  #  make clean || true
  #  make distclean || true
  #fi
  # configure
  autoconf
  eval $CONFIGURE_CMD
  cp $EXECDIR/config.mak.uname $WORKDIR/config.mak.uname
  cp $EXECDIR/config.mak.uname $WORKDIR/config.mak.uname.canary
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make
  TASK=install
fi

package_install
package_bundle

