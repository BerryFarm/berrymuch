# Run this script on phone after Python is installed to get pip working

SETUPTOOLS="setuptools-7.0"
SETUPTOOLS_URL="https://files.pythonhosted.org/packages/0b/48/7298047bf4d67972d9bcb8a546e34f71ee4376d46186615b29678ac33a54/$SETUPTOOLS.tar.gz"

PIP="pip-7.1.1"
PIP_URL="https://files.pythonhosted.org/packages/3b/bb/b3f2a95494fd3f01d3b3ae530e7c0e910dc25e88e30787b0a5e10cbc0640/$PIP.tar.gz"
TEMP_FOLDER=$TEMP/date '+%s'

mkdir $TEMP_FOLDER

cd TEMP_FOLDER
wget $SETUPTOOLS_URL
tar xvf $SETUPTOOLS.tar.gz
cd $SETUPTOOLS
python ez_setup.py

cd TEMP_FOLDER
wget $PIP_URL
tar xvf $PIP.tar.gz
cd $PIP
python setup.py
# pip install complains about not being able to access the index url.
# However if we pass the --index-url flag directly somehow it works.
# So we can install stuff more conveniently by calling `pipi` using this alias:
echo "alias pipi='pip install --index-url=https://pypi.python.org/simple/'" >> $HOME/.profile

cd $HOME
rm -rf $TEMP_FOLDER
