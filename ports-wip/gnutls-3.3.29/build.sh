#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh

DISTVER="gnutls-3.3.29"
DISTSUFFIX="tar.xz"

#
# DEPENDS is only informative for the moment .. 
# some more code would be welcome inside lib.sh or build.sh to make real use of DEPENDS
#  we might implement an ordered list of dependencies, so that first dependency must be compiled before the second, and so on
#  (ie: in the case when second dependency has dependency upon first dependency)
#
DEPENDS="gmp nettle libtasn1" 

#
# BUILD_DEPENDS is only informative for the moment ..
#
BUILD_DEPENDS="automake autogen"
TASK=fetch

DISTFILES="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.3/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xJf"

package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
		--without-p11-kit
		--with-included-libtasn1
		--disable-doc
		--disable-tests
		--disable-valgrind-tests
		--disable-libdane
		--without-tpm
                CC=$PBTARGETARCH-gcc 
                CFLAGS=\"-I$PWD -I$WORKDIR/../gmp-6.1.2 -I$WORKDIR/../nettle-3.4\"
                LDFLAGS=\"-lgmp -L$WORKDIR/../gmp-6.1.2/.libs -lnettle -L$WORKDIR/../nettle-3.4\"
                "
	 	
                
#CFLAGS=\"$CFLAGS -I$PWD -I$WORKDIR/../nettle-3.4\"
#LDFLAGS=\"$LDFLAGS -lnettle -L$WORKDIR/../nettle-3.4\"
#--with-nettle-mini
#--with-included-unistring
#		NETTLE_CFLAGS=\"-I$WORKDIR/../nettle-3.4\"
#		NETTLE_LCFLAGS=\"-L$WORKDIR/../nettle-3.4 -lnettle\"

package_fetch
package_patch 1
package_build
package_install
package_bundle
