# Berrymuch OS

<img src="https://user-images.githubusercontent.com/58649917/71549878-2a45fc00-2a19-11ea-8db8-10c92f3700ec.png"/>

Berrymuch is a user friendly Unix software distribution and a compilation toolchain for the BlackBerry 10 devices.

> If you are into vim, git, taskwarrior or sc and wish you could run them on BB10 you've come to the right place.

The project is standing on the shoulders of giants including [playbook-dev-tools](https://github.com/mordak/playbook-dev-tools) and the effort of multiple awesome CrackBerry forum members.

## Goals

* To provide an easy way to install a variety of useful Unix command line apps and tools
* To simplify porting and compilation (cross- or native-) of POSIX software to BlackBerry 10 QNX
* To engage more Unix and BB10 lovers and tinkerers and have fun
 
## Current status

* GCC 4.6.3 and a variety of libraries are available
* Some useful everyday apps (see [ports](https://github.com/BerryFarm/berrymuch/tree/master/ports)) have been cross-compiled and packaged

## Contact

* Reach us at ( http://t.me/berryfarm_org )

## Roadmap

- Package management with dependencies
- More exciting ports (see the current [Wishlist](https://github.com/BerryFarm/berrymuch/wiki/Wishlist))

## Installation

### User

* Go to [Releases](https://github.com/berryamin/berrymuch/releases) and grab the latest `clitools.zip` and `install.sh`
* Put both into the `documents/` directory on your device
* Install a terminal app (we recommend [term48](https://appworld.blackberry.com/webstore/content/26272878/?lang=en)) and run:

  ```
  cd /accounts/1000/shared/misc/clitools
  sh install.sh
  ```
* Restart your terminal app and enjoy Berrymuch!

### Developer

We use `Docker` container to build the project.
You can build the project by `make build`
Or start the container and connect to it with `make shell`, then you will have everything configured for you inside the conatiner.

For details you can check `Makefile`

You may need to [patch](https://github.com/BerryFarm/berrymuch/wiki/Git-Workflow-HOWTO-create-a-patch-easily-using-git) an existing port


## Disclaimer

This software is provided with no warranty of any kind, may not do what you want, and may not work for you. By installing a compiler onto your device, you may be empowered to make a mess of it - use at your own risk.

We are by no means experts at this and are more than happy to learn and take pull requests if you feel you can make a difference.

## License

You may do whatever you like with this code, provided any copyright notices are preserved.

## See also

* [Wiki](https://github.com/BerryFarm/berrymuch/wiki)
* [FAQ](https://github.com/BerryFarm/berrymuch/wiki/FAQ)
* [Useful links](https://github.com/BerryFarm/berrymuch/wiki/Useful-links)
