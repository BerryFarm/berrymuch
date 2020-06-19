#!/usr/bin/env bash

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
# 
# Carlos Perez-Guerra, 2020

set -e
source ../../lib.sh

DISTVER='python-3.2.2'
PORTROOT=$PWD

apt install mercurial python -y
cd work
git clone https://github.com/BerryFarm/Python
source /root/bbndk/bbndk-env_10_3_1_995.sh
mv Python/Python-3 $DISTVER
rm -rf Python
cd $DISTVER
./build.sh
cd nto-armv7/accounts/1000/shared/documents/clitools
zip -yr $DISTVER.zip .
mv $DISTVER.zip $PORTROOT/packages

