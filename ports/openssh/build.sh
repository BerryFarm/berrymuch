#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="openssh-7.1p2"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"
package_init "$@"
CONFIGURE_CMD="./configure 
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH 
                --target=$PBTARGETARCH 
                --prefix=$PREFIX 
                --disable-etc-default-login
                --with-pid-dir=$PREFIX/var/run
                --with-privsep-path=$PREFIX/var/empty
                --with-sandbox=no
                --disable-strip
                CC=$PBTARGETARCH-gcc 
                AR=$PBTARGETARCH-ar 
                CFLAGS=\"-I$PWD -O3\"
                "
package_fetch
package_patch
cp $EXECDIR/nouid_getpwd.* $WORKDIR/
package_build
package_install

cat > $DESTDIR/$PREFIX/bin/sshd << EOF
#!/bin/sh

if [ ! -f "\$HOME/.ssh/id_rsa" ]; then
ssh-keygen -f \$HOME/.ssh/id_rsa -t rsa -N ''
mv \$HOME/.ssh/id_rsa.pub \$HOME/.ssh/authorized_keys
echo "You need to transfer ~/.ssh/id_rsa to the computer from which you need connect"
else
\$QNX_HOST/sbin/sshd -f/dev/null -oPasswordAuthentication=no -oStrictModes=no -oUsePrivilegeSeparation=no -oSubsystem="sftp \$QNX_HOST/libexec/sftp-server" -oPort=2022 -oHostKey=\$HOME/.ssh/id_rsa "\$@"
fi
EOF
chmod +x $DESTDIR/$PREFIX/bin/sshd

package_bundle


