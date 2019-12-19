#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.


set -e
source ../../lib.sh
DISTVER="gettext-0.18.1.1"
DISTSUFFIX="tar.gz"
TASK=fetch

DISTFILES="http://ftp.gnu.org/gnu/gettext/$DISTVER.$DISTSUFFIX"
UNPACKCOMD="tar -xzf"

package_init "$@"
CONFIGURE_CMD="./configure 
              --host=$PBHOSTARCH
              --build=$PBBUILDARCH
              --target=$PBTARGETARCH
              --prefix=$PREFIX 
              --disable-nls 
              --enable-threads=posix 
              --enable-relocatable 
              --enable-java=no 
              --disable-java 
              --disable-native-java 
              --enable-csharp=no 
              --disable-csharp 
              --without-included-gettext 
              --without-git 
              --without-cvs 
              --without-emacs 
              CC=$PBTARGETARCH-gcc 
              ac_cv_prog_AWK=`which awk`
              ac_cv_path_GREP=`which grep` 
              ac_cv_path_SED=`which sed`
              "
  
package_fetch
package_patch
package_build
package_install
package_bundle


