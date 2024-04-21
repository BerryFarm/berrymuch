#!/bin/sh


# versions up to 0.4 were slowing down the device (see #54)
D=/accounts/1000/shared/documents/clitools
if [ -d $D ]; then
 if [ "x$1" == "x-f" ]; then
    echo 
    echo "skipping check of previous Berrymuch version (<0.5)"
    echo 
 else
    echo
    echo "previous version of Berrymuch (<0.5) has been detected"
    echo "please remove the previous installation by typing"
    echo
    echo "  rm -rf /accounts/1000/shared/documents/clitools"
    echo "  $0"
    echo 
    echo "if you want to bypass this check, use install -f"
    echo 
    echo
    exit 0
 fi
fi

D=/accounts/1000/shared/misc/clitools
mkdir -p $D;

ipfs_installer () {

}
	
echo
echo "do you want to perform a net install using ipfs ?"
echo -n "(y/n)"
read -n 1 answer
echo

[ $answer == "y" ] && {
	ipfs_installer
	exit 0
}
   
mv clitools.zip $D
cd $D
touch .nomedia .noindex
unzip clitools.zip
. ./env.sh
for pkg in packages/*.zip
do
./pbpkgadd $pkg
done

if [ ! -e "$HOME/.profile" ]; then
  cp "$PWD/sample_profile" "$HOME/.profile"
else
  echo "You already have a .profile."
  echo "You can set up your paths by sourcing $PWD/env.sh"
  echo "See $PWD/sample_profile for a snippet that does this"
fi

mkdir -p etc/qnxconf/qconfig
CONFFILE="etc/qnxconf/qconfig/qnx_blackberry_native_development_kit_2.1.0.xml"

echo "<?xml version="1.0" ?>"                                     >  $CONFFILE
echo "<qnxSystemDefinition>"                                      >> $CONFFILE
echo "  <installation>"                                           >> $CONFFILE
echo "    <base>$PWD</base>"                                      >> $CONFFILE
echo "    <name>BlackBerry Native SDK for Tablet OS 2.1.0</name>" >> $CONFFILE
echo "    <host>$PWD</host>"                                      >> $CONFFILE
echo "    <target>$PWD/target/qnx6</target>"                      >> $CONFFILE
echo "  </installation>"                                          >> $CONFFILE
echo "</qnxSystemDefinition>"                                     >> $CONFFILE

mkdir -p bin
mv pbpkgadd ./bin
