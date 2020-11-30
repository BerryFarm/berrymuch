#!/bin/bash

# needs libtool, currently not avaible in the Dockerfile

# adapted from
# https://raw.githubusercontent.com/extrowerk/bb10-toolchain/master/build.sh

# PERSONALIZATON :

# You probably want to change this:

export HOST_CC="gcc" # default: gcc
export CPU_COUNT="4"
export LANGS="c,c++" # default: c,c++ but fortran should also work

# ----------------------------------------

# GLOBAL EXPORTS :

export HOST_KERNEL=`uname -s | tr '[:upper:]' '[:lower:]'` # should be lowercase, default: linux
export HOST_PLATFORM=`uname -i`
export HOST_MACHINE=`uname -m`
export OUTPUT_FOLDER="/opt/qnx800" # default: /opt/qnx800
export TARGET_FOLDER="$OUTPUT_FOLDER/target" # default: /opt/qnx800/target
export HOST_FOLDER="$OUTPUT_FOLDER/host" # default: /opt/qnx800/host
export TARGET_ABI="arm-unknown-nto-qnx8.0.0eabi" # default: arm-unknown-nto-qnx8.0.0eabi
export HOST_OS="$HOST_MACHINE-$HOST_PLATFORM-$HOST_KERNEL-gnu" # default: i686-pc-linux-gnu
export PREFIX="$HOST_FOLDER/$HOST_KERNEL/$HOST_MACHINE/usr"
export BUGURL="https://github.com/extrowerk/bb10-toolchain/"

# ----------------------------------------

# ENVIRONMENT :

source /root/bbndk/bbndk-env_10_3_1_995.sh
export PATH="$PREFIX/bin:$PATH"
export LIBDIR="$PREFIX/lib:$LIBDIR"

# ----------------------------------------

# PREPARATION :

rm -rf "$OUTPUT_FOLDER"
mkdir -p "$TARGET_FOLDER/qnx6/usr/"

cp -R /root/bbndk/target_10_3_1_995/qnx6/usr/include/ "$TARGET_FOLDER/qnx6/usr/" && # Let's run it in the background

mkdir -p BB10_tools
cd BB10_tools

# ----------------------------------------

# DOWNLOADS :

#wget https://ftp.fau.de/gnu/binutils/binutils-2.35.tar.xz # this is just the vanilla binutils
#tar -xvf binutils-2.35.tar.xz
#mv binutils-2.35 bb10-binutils

[ -d bb10-binutils ] 	|| git clone --single-branch --branch 700_release --depth 1 https://github.com/extrowerk/bb10-binutils.git
[ -d bb10-gcc ] 	|| git clone --single-branch --branch 700_release --depth 1 https://github.com/extrowerk/bb10-gcc.git
[ -d bb10-gcc/mpc ] 	|| git clone --single-branch --branch 700_release --depth 1 https://github.com/extrowerk/bb10-libmpc.git bb10-gcc/mpc
[ -d bb10-gcc/gmp ] 	|| git clone --single-branch --branch 700_release --depth 1 https://github.com/extrowerk/bb10-libgmp.git bb10-gcc/gmp
[ -d bb10-gcc/mpfr ] 	|| git clone --single-branch --branch 700_release --depth 1 https://github.com/extrowerk/bb10-libmpfr.git bb10-gcc/mpfr

# ----------------------------------------

# RECONFIGURE MPFR :

cd bb10-gcc/mpfr
# make sure you have autoconf-archive installed!
autoreconf -f -i  || exit 1
cd ../..

# ----------------------------------------

set -e # Exit on first error

# ----------------------------------------

# BINUTILS :

mkdir -p bb10-binutils-build
cd bb10-binutils-build

../bb10-binutils/configure \
    --srcdir=../bb10-binutils \
    --build="$HOST_OS" \
    --with-sysroot="$TARGET_FOLDER/qnx6/" \
    --disable-werror \
    --libdir="$PREFIX/lib" \
    --libexecdir="$PREFIX/lib" \
    --target="$TARGET_ABI" \
    --prefix="$PREFIX" \
    --exec-prefix="$PREFIX" \
    --with-local-prefix="$PREFIX" \
    CC="$HOST_CC" \
    LDFLAGS="-Wl,-s " \
    AUTOMAKE=: AUTOCONF=: AUTOHEADER=: AUTORECONF=: ACLOCAL=:

make -j "$CPU_COUNT" || exit 1
make install || exit 1
cd ..

# ----------------------------------------

# GCC :

mkdir -p bb10-gcc-build
cd bb10-gcc-build

export CFLAGS="" # maybe unneeded
export CFLAGS_FOR_BUILD="" # maybe unneeded
export CFLAGS_FOR_TARGET="-g" # TODO: check why as bails out without this.
export CXXFLAGS="" # maybe unneeded
export CXXFLAGS_FOR_BUILD="" # maybe unneeded
export CXXFLAGS_FOR_TARGET="-g" # TODO: check why as bails out without this.


../bb10-gcc/configure \
    --srcdir=../bb10-gcc \
    --build="$HOST_OS" \
    --enable-cheaders=c \
    --with-as="$PREFIX/bin/$TARGET_ABI"-as \
    --with-ld="$PREFIX/bin/$TARGET_ABI"-ld \
    --with-sysroot="$TARGET_FOLDER/qnx6/" \
    --disable-werror \
    --libdir="$PREFIX/lib" \
    --libexecdir="$PREFIX/lib" \
    --target="$TARGET_ABI" \
    --prefix="$PREFIX" \
    --exec-prefix="$PREFIX" \
    --with-local-prefix="$PREFIX" \
    --enable-languages="$LANGS" \
    --enable-threads=posix \
    --disable-nls \
    --disable-tls \
    --disable-libssp \
    --disable-libstdcxx-pch \
    --enable-libmudflap \
    --enable-__cxa_atexit \
    --with-gxx-include-dir="$TARGET_FOLDER/qnx6/usr/include/c++/5.4.0" \
    --enable-shared \
    --enable-multilib \
    --with-bugurl="$BUGURL" \
    --enable-gnu-indirect-function \
    --enable-stack-protector \
    --with-float=softfp \
    --with-arch=armv7-a \
    --with-fpu=vfpv3-d16 \
    --with-mode=thumb \
    CC="$HOST_CC" \
    LDFLAGS="-Wl,-s " \
    AUTOMAKE=: AUTOCONF=: AUTOHEADER=: AUTORECONF=: ACLOCAL=:

make all -j "$CPU_COUNT" || exit 1
make install-strip || exit 1

# CLEANUP

# We need to create a symlink: libstdc++.{a,so} > libc++.{a,so}
# This is strange, do QNX cals it so?

LIBDIR="$PREFIX/$TARGET_ABI/lib"
ln -s $LIBDIR/libstdc++.so $LIBDIR/libc++.so
ln -s $LIBDIR/libstdc++.a $LIBDIR/libc++.a

echo "Have fun!"
