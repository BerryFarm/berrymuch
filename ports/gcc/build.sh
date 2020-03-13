#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=fetch

DISTVER="gcc"

package_init "$@"

if [ "$TASK" == "fetch" ]
then
  cd "$EXECDIR"
  # fetch
  echo "Fetching gcc sources if not already present"
pwd
  ls -d gcc 2>/dev/null 2>&1 || \
{ 
  git clone https://github.com/berryfarm/gcc gcc.tmp
  mv gcc.tmp/gcc .
  rm -rf gcc.tmp
}

  TASK=build
fi

CONFIGURE_CMD="$EXECDIR/gcc/configure 
                   --host=$PBHOSTARCH 
                   --build=$PBBUILDARCH 
                   --target=$PBTARGETARCH 
                   MAKEINFO='/usr/bin/makeinfo --force'
                   --srcdir=$EXECDIR/gcc 
                   --with-as=ntoarm-as 
                   --with-ld=ntoarm-ld 
                   --with-sysroot=$QNX_TARGET 
                   --disable-werror 
                   --prefix=$PREFIX 
                   --exec-prefix=$PREFIX 
                   --libdir=$PREFIX/lib
                   --libexecdir=$PREFIX/lib
                   --with-local-prefix=$PREFIX
                   --enable-cheaders=c 
                   --enable-languages=c++ 
                   --enable-threads=posix 
                   --disable-nls 
                   --disable-libssp 
                   --disable-tls 
                   --disable-libstdcxx-pch 
                   --enable-libmudflap 
                   --enable-__cxa_atexit 
                   --with-gxx-include-dir=$PREFIX/$TARGETNAME/qnx6/usr/include/c++/4.6.3 
                   --enable-multilib 
                   --enable-shared 
                   --enable-gnu-indirect-function 
                   --with-arch=armv7-a --with-float=softfp --with-fpu=vfpv3-d16 --with-mode=thumb
                   CC=$PBTARGETARCH-gcc 
                   LDFLAGS='-Wl,-s ' 
                   AUTOMAKE=: AUTOCONF=: AUTOHEADER=: AUTORECONF=: ACLOCAL=:
                   "
package_build
package_install

cd "$DESTDIR/$PREFIX/bin"
# escape pkgsrc jail
ln -sf ./gcc ./gcc.pkgsrc

# these are broken
rm -rf $DESTDIR/$PREFIX/$TARGETNAME/qnx6/usr/include
cp $EXECDIR/ldd $DESTDIR/$PREFIX/bin/
  
package_bundle

# and pack up the system headers, etc
cd "$BBTOOLS"
zip -r -u -y "$ZIPFILE" $TARGETNAME/qnx6/armle-v7/lib $TARGETNAME/qnx6/usr/include --exclude \*qt4\* || true
zip -r -u -y "$ZIPFILE" $TARGETNAME/qnx6/armle-v7/usr/lib --exclude \*qt4\* || true


