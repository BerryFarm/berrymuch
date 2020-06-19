# Run this script on phone after Python is installed to get pip working

RANGER="ranger-1.6.0"
RANGER_URL="https://github.com/ranger/ranger/archive/v1.6.0.tar.gz"

TEMP_FOLDER=$TEMP/date '+%s'

mkdir $TEMP_FOLDER

cd TEMP_FOLDER
wget $RANGER_URL
tar xvf $RANGER.tar.gz
cd $RANGER
python setup.py

cd $HOME
rm -rf $TEMP_FOLDER
