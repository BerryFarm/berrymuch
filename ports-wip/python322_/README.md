So this is a recipe which wraps the build script in the Blackberry Python repo to comply with our build workflow. Some quick comments:

The procedure to get the latest compatible version of `pip` working as well is as follows:
1. Make sure this python is installed (not just the interpreter but the whole thing including the `lib` directory).
2. Make sure `wget` is installed.
3. Download and run `sh pip.sh` on the phone. This script first downloads some very early versions of `setuptools` and `pip`, and then uses those to install the latest compatible versions. 
4. To install something use the alias `pipi <package name>` instead of `pip install`. It seems there is something broken with `pip install` as it can't seem to fetch the index url unless it is passed explicitly with the `--index-url` flag, so the alias is written out to your `.profile` for convenience. 

INSTALLING PACKAGES
Some packages, like `ranger` can be installed without specifying a version number (just do `pipi ranger`), since they are cross-compatible with Python 3.2, but most Python software is likely to only support versions 3.4+. Although I suppose `pip` will try to install the latest compatible version, many of the packages in the official Pypy repository are incorrectly labeled as compatible with Python 3, instead of 3.4+, so the installation will fail because of the differences in syntax. Look for older versions and install those instead: `pipi <package name>==<version>`. Anything from 2013/2014 is a safe bet (as long as it doesn't depend on some librararies we haven't ported).

FUTURE CROSS-COMPILATION
It should be possible to cross-compile step 3, hence significantly reducing the install time, which is why my build recipe also outputs a `host` directory with the python host. It is there for future cross-compilation efforts. Setuptools does indeed compile some C or C++ code, so this would have to be accounted for (environment variables? patches?). At any rate, doing it on the phone directly works well enough if one is not in a hurry.

