#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="tgl"
DEPENDS="libevent openssl jansson"
DEPENDS_PKGS="libevent-2.0.22-stable.zip readline-7.0.zip"
TASK=fetch

TG_GITVER=1.3.1

package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		--without-zlib
		CFLAGS=\"-I../libevent-2.0.22-stable/include/event2 -I../readline-7.0/include/readline\"
		LDFLAGS=\"-L../libevent-2.0.22-stable/lib -L../readline-7.0/lib -lsocket -levent -lreadline\"
                CC=$PBTARGETARCH-gcc
                MAKEINFO='/usr/bin/makeinfo --force'
                "

if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  # delete old version
  rm -rf "$DISTVER"
#  git clone git://git.sv.gnu.org/findutils $DISTVER
  git clone --recursive https://github.com/vysheng/tg.git $DISTVER
  cd $DISTVER
  git checkout $TG_GITVER
  cd "$WORKDIR"
  TASK=patch
fi

package_patch 1


if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"
  # clean up if we have a previous build
  #if [ -e "Makefile" ]; then
  #  make clean || true
  #  make distclean || true
  #fi

  for zipfile in $DEPENDS_PKGS
   do
	D=$WORKROOT/$(echo $zipfile | sed 's/.zip//g')
	[ -d $D ] && continue

	mkdir $D || exit 1
	echo 
	echo DEBUG unzip $PKGDIR/$zipfile -d $WORKROOT/$D
	echo 
	read P
	echo 
	unzip $PKGDIR/$zipfile -d $D
	echo 
	read P
   done

  # configure
  eval $CONFIGURE_CMD
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
        eval $MAKE_PREFIX make


  TASK=install
fi

package_install
package_bundle


