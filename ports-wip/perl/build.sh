#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
source ./vars.sh
TASK=fetch

DISTFILES="http://www.cpan.org/src/5.0/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="
    cd $WORKDIR/.. && \
    curl -L -O https://github.com/arsv/perl-cross/releases/download/1.1.3/perl-cross-1.1.3.tar.gz && \
    cd $WORKDIR && \
    tar --strip-components=1 -zxf ../perl-cross-1.1.3.tar.gz &&
    ./configure
    --target=$PBTARGETARCH
    --prefix=$PREFIX
    CC=$PBTARGETARCH-gcc
"
# ; make CC=$PBTARGETARCH-gcc AR=$PBTARGETARCH-ar RANLIB=$PBTARGETARCH-ranlib CFLAGS=-O3"

package_fetch
package_patch
package_build

if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make install PREFIX="$DESTDIR/$PREFIX"
 	cd "$DESTDIR/$PREFIX/bin"
  TASK=bundle
fi


package_bundle

