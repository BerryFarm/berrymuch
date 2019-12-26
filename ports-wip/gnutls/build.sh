#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
source ./vars.sh
TASK=fetch

DISTFILES="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"

package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		--without-p11-kit
		--with-included-libtasn1
		--with-included-unistring
		--disable-doc
		--disable-tests
		--disable-valgrind-tests
		--disable-libdane
		--disable-psk-authentication
		--without-tpm
                CC=$PBTARGETARCH-gcc 
                CFLAGS=\"-I$PWD -I$WORKROOT/nettle-3.4 -I$WORKROOT/gmp-6.1.2\"
                LDFLAGS=\"-lnettle -lhogweed -lgmp -L$WORKROOT/nettle-3.4/.lib -L$WORKROOT/gmp-6.1.2/.libs\"
                "
	 	
#		--with-nettle-mini
#		NETTLE_CFLAGS=\"-I$WORKROOT/nettle-3.1\"
#		NETTLE_LDFLAGS=\"-L$WORKROOT/nettle-3.1/.lib -lnettle\"

package_fetch

if [ "$TASK" == "patch" ]
then
  echo "Patching .. "
  cd "$WORKDIR"
  if [ -e "$EXECDIR/patches" ]; then
    for apatch in $EXECDIR/patches/*
    do
      patch -p1 < $apatch
    done
  fi

# For gnutls-3.3 only
#  mv $WORKDIR/libtool $WORKDIR/libtool.orig
#  cp /usr/local/Cellar/libtool/2.4.6_1/bin/glibtool $WORKDIR/libtool

  TASK=build
fi

package_build
package_install
package_bundle

