# Berrymuch OS

Berrymuch is a user friendly Unix software distribution and a compilation toolchain for the BlackBerry 10 devices.

> If you are into vim, git, taskwarrior or sc and wish you could run them on BB10 you've come to the right place.

The project is standing on the shoulders of giants including [playbook-dev-tools](https://github.com/mordak/playbook-dev-tools) and the effort of multiple awesome CrackBerry forum members.

## Goals

* To provide an easy way to install a variety of useful Unix command line apps and tools
* To simplify porting and compilation (cross- or native-) of POSIX software to BlackBerry 10 QNX
* To engage more Unix and BB10 lovers and tinkerers and have fun
 
## Current status

* GCC 4.6.3 and a variety of libraries are available
* Some useful everyday apps (e.g. vim) have been cross-compiled and packaged 

## Roadmap

- Infrastructure for native-compiled apps (ports-like system)
  * Potentially leveraging the pkgsrc development

## Installation

### User

* Go to [Releases](https://github.com/berryamin/berrymuch/releases) and grab the latest `clitools.zip` and `install.sh`
* Put both into the `documents/` directory on your device
* Install a terminal app (we recommend [term48](https://appworld.blackberry.com/webstore/content/26272878/?lang=en)) and run:

  ```
  cd /accounts/1000/shared/documents
  ./install.sh
  ```
* Restart your terminal app and enjoy Berrymuch!

### Developer

* Get an OS supported by the BlackBerry Native SDK (we recommend [32-bit Ubuntu 16.04](http://releases.ubuntu.com/16.04/ubuntu-16.04.6-desktop-i386.iso))
* Install the [BlackBerry Native SDK](https://developer.blackberry.com/native/download/)
* Install a few other packages:
  ```
  sudo apt install git subversion curl texinfo autopoint m4 autoconf groff lunzip
  ```
* Clone this repository and run `./build.sh`
* Follow the instructions at the end of the build process

## Disclaimer

This software is provided with no warranty of any kind, may not do what you want, and may not work for you. By installing a compiler onto your device, you may be empowered to make a mess of it - use at your own risk.

We are by no means experts at this and are more than happy to learn and take pull requests if you feel you can make a difference.

## License

You may do whatever you like with this code, provided any copyright notices are preserved.

## See also

* [term48](https://github.com/mordak/Term48)
* [playbook-dev-tools](https://github.com/mordak/playbook-dev-tools)
* https://forums.crackberry.com/blackberry-10-os-f269/blackberry-10-hacks-unix-tinkerers-961115/
* https://forums.crackberry.com/bb-10-developers-hangout-f276/ffmpeg-wget-binaries-1115693/

