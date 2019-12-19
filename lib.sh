
# common functions for the build tools

# This code Copyright 2012 Todd Mortimer <todd.mortimer@gmail.com>
#
# You may do whatever you like with this code, provided the above
# copyright notice and this paragraph are preserved.
#
# Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 2018


PBHOSTARCH=arm-unknown-nto-qnx8.0.0eabi
PBBUILDARCH=`gcc -dumpmachine`
PBTARGETARCH=arm-unknown-nto-qnx8.0.0eabi

DEFAULTPREFIX='/accounts/1000/shared/documents/clitools'

usage()
{
cat << EOF
usage: $0 options

Run this to fetch, patch, build, bundle and deploy dev tools for the playbook.

OPTIONS:
   -h      Show this message
   -b      The absolute path to your BB Native SDK folder [/abs/path/tp/bbndk]
   -i      The IP address of this machine (will prompt if not specified)
   -l      The login you use for the QNX Foundry27 site, if you have one [user@host]
   -p      The prefix on your BB10 device to install to (default $DEFAULTPREFIX)
   -t      The build task to perform: [ build_all | bundle | deploy]
   -s      The task to pass to each package [fetch | patch | build | install | bundle]
EOF
}

process_args()
{
  SUBTASKFLAG=
  SUBTASK=
  while getopts "b:i:l:t:hs:p:" OPTION
  do
    case "$OPTION" in
      h) usage; exit 1;;
      b) echo "$OPTARG" > conf/bbtools;;
      l) echo "$OPTARG" > conf/login;;
      p) echo "$OPTARG" > conf/prefix;;
      t) TASK="$OPTARG";;
      s) SUBTASK="$OPTARG"; SUBTASKFLAG="-t";;
    esac
  done

}

function check_required_binaries()
{
	I=0
	while [ -z != ${BUILD_DEP_BINS[$I]} ];
	do
		type ${BUILD_DEP_BINS[$I]} || {
			echo "Fatal: binary ${BUILD_DEP_BINS[$I]} not found. Required for build"
			exit 1
		}
		let I=$(($I+1))
	done
}

function source_bbtools()
{
  if [ -e "$ROOTDIR/conf/bbtools" ]; then
    BBTOOLS=`cat "$ROOTDIR/conf/bbtools"`
  else
    # TODO prompt the user
    usage
    exit 1
  fi

  # test the existence of the bbndk-env file
  if ! ls $BBTOOLS/bbndk-env*.sh >/dev/null 2>&1
  then
    echo "Cannot source $BBTOOLS/bbndk-env.sh. Pass -b [path] to specify."
    exit 1
  fi

  # and source
  source $BBTOOLS/bbndk-env*.sh
  TARGETNAME=`basename $(dirname $QNX_TARGET)`

}

function get_foundry_login()
{
  LOGIN="guest --password \"\""
  if [ -e "$ROOTDIR/conf/login" ]; then
    LOGIN=`cat "$ROOTDIR/conf/login"`
  fi
}

function get_prefix()
{
  PREFIX="$DEFAULTPREFIX"
  if [ -e "$ROOTDIR/conf/prefix" ]; then
    PREFIX=`cat "$ROOTDIR/conf/prefix"`
  fi
}

function init_confdir()
{
  mkdir -p conf
  # cache the root directory if we haven't yet
  if [ ! -e "conf/rootdir" ]; then
    echo "$PWD" > conf/rootdir
  fi
}

function configure_dirs()
{
  # we are either the root build.sh, or a subdir
  if [ -e "conf/rootdir" ]; then
    ROOTDIR=`cat conf/rootdir`
  elif [ -e ../../conf/rootdir ]; then
    ROOTDIR=`cat ../../conf/rootdir`
  else
    # first run
    init_confdir
    ROOTDIR=`cat conf/rootdir`
  fi
  DESTDIR="$ROOTDIR/clitools"
  mkdir -p "$DESTDIR"
  ARCHIVEDIR="$ROOTDIR/archive"
  mkdir -p "$ARCHIVEDIR"
  PKGDIR="$ROOTDIR/packages"
  mkdir -p "$PKGDIR"
  WORKROOT="$ROOTDIR/work"
  mkdir -p "$WORKROOT"
  PORTSDIR="$ROOTDIR/ports"
  ZIPFILE="$ROOTDIR/clitools.zip"
}

function init()
{
  init_confdir
  process_args "$@"
  configure_dirs
  source_bbtools
  get_foundry_login
  get_prefix
}

function build_all()
{
  ALLPORTS="bash bc bison bzip2 cflow coreutils curl diffutils ed fakeroot file gcc gdb gdbm gettext git grep groff gzip jansson libevent libmpg123 libuuid m4 make man openssh openssl patch rsync sqlite tar taskwarrior tmux vim xz yaml zeromq zlib"
  BROKEN="cronie findutils ruby"

  cd "$PORTSDIR"
  for dir in $ALLPORTS
  do
    if [ -d "$dir" ] && [ -e "$dir/build.sh" ]; then
      [ -f "$dir/vars.sh" ] && {
        . $dir/vars.sh
        [ -f ../packages/$DISTVER.zip ] && {
          echo "Warning: skipping build of $DISTVER (file packages/$DISTVER.zip already exists) "
          continue;
        }
      }
      echo "Building $dir"
      cd "$dir"
      ./build.sh $SUBTASKFLAG $SUBTASK
      cd "$PORTSDIR"
    fi
  done
}

function subusage()
{
cat << EOF
usage: $0 options

Run this to fetch, patch, build, bundle and deploy $DISTVER for the playbook.

OPTIONS:
   -h      Show this message
   -b      The absolute path to your bbpb-sdk folder [/abs/path/tp/bbpb-sdk]
   -t      The build task to start at: [fetch | patch | build | install | bundle]
   -i      The IP address of this machine
   -l      The login you use for the QNX Foundry27 site, if you have one [user@host]
   -p      The prefix on your BB10 device to install to (default $DEFAULTPREFIX)
EOF
}

function process_subargs()
{
while getopts "b:l:t:i:hp:" OPTION
do
  case "$OPTION" in
    h) subusage; exit 1;;
    b) echo "$OPTARG" > "$ROOTDIR/conf/bbtools";;
    l) echo "$OPTARG" > "$ROOTDIR/conf/login";;
    p) echo "$OPTARG" > "$ROOTDIR/conf/prefix";;
    t) TASK="$OPTARG";;
  esac
done
}

function package_init()
{
  configure_dirs
  process_subargs "$@"
  source_bbtools
  get_foundry_login
  get_prefix

  EXECDIR="$PWD"
  WORKDIR="$WORKROOT/$DISTVER"
  mkdir -p "$WORKDIR"
  ZIPFILE="$PKGDIR/$DISTVER.zip"
}

function package_fetch()
{
if [ "$TASK" == "fetch" ]
then
  cd "$WORKROOT"
  echo "Fetching sources"
  if [ ! -f $DISTVER.$DISTSUFFIX ]; then
    curl -fkSLO $DISTFILES
  fi

  # Unpack and organize
  echo "Unpacking"
  $UNPACKCOMD $DISTVER.$DISTSUFFIX
  TASK=patch
fi
}

function package_patch()
{
if [ "$TASK" == "patch" ]
then
  echo "Patching .. "
  cd "$WORKDIR"
  PATCHLEVEL=$1
  if [ -z $1 ]; then
    PATCHLEVEL=0
  fi
  if [ -e "$EXECDIR/patches" ]; then
    for apatch in $EXECDIR/patches/*
    do
      patch -p$PATCHLEVEL < $apatch
    done
  fi
  TASK=build
fi
}

function package_build()
{
if [ "$TASK" == "build" ]
then
  echo "Building"
  cd "$WORKDIR"
  # clean up if we have a previous build
  #if [ -e "Makefile" ]; then
  #  make clean || true
  #  make distclean || true
  #fi
  # configure
  eval $CONFIGURE_CMD
  eval $MAKE_PREFIX make $MYMAKEFLAGS || \
  eval $MAKE_PREFIX make
  TASK=install
fi
}

function package_install()
{
if [ "$TASK" == "install" ]
then
  cd "$WORKDIR"
  make DESTDIR="$DESTDIR" install
  TASK=bundle
fi
}

function package_bundle()
{
if [ "$TASK" == "bundle" ]
then
  echo "Bundling"
  cd "$DESTDIR/$PREFIX"
  zip -r -y -u "$ZIPFILE" * || true
  mv "$DESTDIR" "$ARCHIVEDIR/$DISTVER"
fi
}

# we call configure_dirs here so when the library is included,
# the directories get set up early.
configure_dirs

