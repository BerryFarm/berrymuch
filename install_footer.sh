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
