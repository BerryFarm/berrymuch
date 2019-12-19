#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="vim-8.0"
DISTSUFFIX="tar.bz2"
TASK=fetch

DISTFILES="ftp://ftp.vim.org/pub/vim/unix/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xf"

package_init "$@"

WORKDIR="$WORKROOT/vim80"
CONFIGURE_CMD="vim_cv_memmove_handles_overlap=yes vim_cv_stat_ignores_slash=yes vim_cv_getcwd_broken=no vim_cv_toupper_broken=no vim_cv_terminfo=yes vim_cv_tty_group=world \
                ./configure
                --host=$PBHOSTARCH
                --build=$PBBUILDARCH
                --target=$PBTARGETARCH
                --prefix=$PREFIX
                --enable-gui=no
                LIBS=-lncurses
                CC=$PBTARGETARCH-gcc
                "
package_fetch
package_patch
package_build
package_install

rm -rf $DESTDIR/$PREFIX/share/vim/vim80/{doc,tutor}

package_bundle

