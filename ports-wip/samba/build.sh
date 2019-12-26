#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="samba-4.8.1"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="https://download.samba.org/pub/samba/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
# No configure, just make
CONFIGURE_CMD="python ./buildtools/bin/waf configure --without-acl-support --without-ad-dc --disable-python --without-ldap --without-ads --disable-cups --without-quotas --without-utmp --without-pam --without-syslog --without-fam --without-fake-kaserver --disable-glusterfs --disable-cephfs --without-systemd --without-lttng --cross-compile --cross-execute=$PBTARGETARCH- --hostcc=$PBHOSTARCH-gcc --target=$PBTARGETARCH"
# --check-c-compiler=$PBTARGETARCH-gcc"
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

