#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
TASK=build

DISTVER="gcc"

package_init "$@"

if [ "$TASK" == "fetch" ]
then
  cd "$EXECDIR"
  # move aside previous downloads
  mv gcc gcc-old || true
  # fetch
  echo "Fetching gcc sources"
  svn checkout --username $LOGIN http://community.qnx.com/svn/repos/core-dev-tools/tools/binutils/branches/binutils-2.22
  mv binutils-2.22 binutils
  svn checkout --username $LOGIN http://community.qnx.com/svn/repos/core-dev-tools/tools/gcc/branches/gcc_4_6_ndk_branch
  mv gcc_4_6_ndk_branch gcc
  curl -O http://ftp.gnu.org/gnu/gmp/gmp-4.3.2.tar.bz2
  curl -O http://ftp.gnu.org/gnu/mpfr/mpfr-2.4.2.tar.bz2
  curl -O http://ftp.gnu.org/gnu/mpc/mpc-1.0.2.tar.gz

  # Unpack and organize
  echo "Unpacking"
  mv binutils gcc/
  mv gmp-4.3.2.tar.bz2 gcc/
  mv mpfr-2.4.2.tar.bz2 gcc/
  mv mpc-1.0.2.tar.gz gcc/
  cd gcc
  tar -xjf gmp-4.3.2.tar.bz2
  tar -xjf mpfr-2.4.2.tar.bz2
  tar -xjf mpc-1.0.2.tar.gz
  mv gmp-4.3.2 gmp
  mv mpfr-2.4.2 mpfr
  mv mpc-1.0.2 mpc

  TASK=patch
fi

if [ "$TASK" == "patch" ]
then
  echo "Patching .. "
  cd "$EXECDIR"
  #patch -p0 < patches/binutils-gas-configure.tgt.diff
  patch -p0 < patches/g++-fix.diff
  TASK=build
fi

CONFIGURE_CMD="$EXECDIR/gcc/configure 
                   --host=$PBHOSTARCH 
                   --build=$PBBUILDARCH 
                   --target=$PBTARGETARCH 
                   --srcdir=$EXECDIR/gcc 
                   --with-as=ntoarm-as 
                   --with-ld=ntoarm-ld 
                   --with-sysroot=$QNX_TARGET 
                   --disable-werror 
                   --prefix=$DESTDIR 
                   --exec-prefix=$DESTDIR 
                   --enable-cheaders=c 
                   --enable-languages=c++ 
                   --enable-threads=posix 
                   --disable-nls 
                   --disable-libssp 
                   --disable-tls 
                   --disable-libstdcxx-pch 
                   --enable-libmudflap 
                   --enable-__cxa_atexit 
                   --with-gxx-include-dir=$QNX_TARGET/usr/include/c++/4.6.3 
                   --enable-multilib 
                   --enable-shared 
                   --enable-gnu-indirect-function 
                   CC=$PBTARGETARCH-gcc 
                   LDFLAGS='-Wl,-s ' 
                   AUTOMAKE=: AUTOCONF=: AUTOHEADER=: AUTORECONF=: ACLOCAL=:
                   "
package_build
package_install

cd "$DESTDIR/bin"
# link stuff to where the compiler will find it
if [ ! -e cc1 ]; then
  ln -s ../libexec/gcc/$PBTARGETARCH/4.6.3/cc1 ./cc1
fi
if [ ! -e cc1plus ]; then
  ln -s ../libexec/gcc/$PBTARGETARCH/4.6.3/cc1plus ./cc1plus
fi
if [ ! -e collect2 ]; then
  ln -s ../libexec/gcc/$PBTARGETARCH/4.6.3/collect2 ./collect2
fi
  
package_bundle

# and pack up the system headers, etc
cd "$BBTOOLS"
zip -r -u -y "$ZIPFILE" $TARGETNAME/qnx6/armle-v7 $TARGETNAME/qnx6/etc $TARGETNAME/qnx6/usr/include || true


