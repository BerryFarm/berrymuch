#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.

set -e

source lib.sh

TASK=build_all

init "$@"

if [ "$TASK" == "build_all" ]
then
  build_all
  TASK=bundle
fi

if [ "$TASK" == "bundle" ]
then
  cd "$ROOTDIR"
  echo "Setting up target env"
  echo "export NATIVE_TOOLS=\"$PREFIX\"" > env.sh
  echo "QNX_TARGET=\$NATIVE_TOOLS/$TARGETNAME/qnx6" >> env.sh
  cat profile >> env.sh
  echo "umask 002"                   >  sample_profile
  echo "CLITOOLS=\"$PREFIX/env.sh\"" >> sample_profile
  echo 'if [ -e $CLITOOLS ];then'    >> sample_profile
  echo '    . $CLITOOLS'             >> sample_profile
  echo 'fi'                          >> sample_profile
  ZIPFILE="$DESTDIR.zip"
  zip -u "$ZIPFILE" env.sh qconf-override.mk pbpkgadd sample_profile || true
  zip -u "$ZIPFILE" packages/*.zip || true
  TASK=deploy
fi

if [ "$TASK" == "deploy" ]
then
  cd "$ROOTDIR"
  echo "#!/bin/sh"                                                              >  install.sh
  echo "mkdir -p \"$PREFIX\""                                                   >> install.sh
  echo "mv clitools.zip \"$PREFIX\""                                            >> install.sh
  echo "cd \"$PREFIX\""                                                         >> install.sh
  echo "unzip clitools.zip"                                                     >> install.sh
  echo 'for pkg in packages/*.zip'                                              >> install.sh
  echo 'do'                                                                     >> install.sh
  echo './pbpkgadd $pkg'                                                        >> install.sh
  echo 'done'                                                                   >> install.sh
  echo '. ./env.sh'                                                             >> install.sh
  cat install_footer.sh                                                         >> install.sh
  echo "---- You can now download clitools.zip and install.sh to your device from http://thismachine:8888"
  python3 -m http.server 8888
fi

