NATIVE_TOOLS="/accounts/1000/shared/documents/clitools"
QNX_TARGET=$NATIVE_TOOLS/target_10_3_1_995/qnx6
export NATIVE_TOOLS QNX_TARGET

PATH="$NATIVE_TOOLS/bin:$NATIVE_TOOLS/sbin:$PATH"
LD_LIBRARY_PATH="$NATIVE_TOOLS/lib:$QNX_TARGET/armle-v7/usr/lib:$LD_LIBRARY_PATH"
export PATH LD_LIBRARY_PATH

#MAKEFLAGS="-I$NATIVE_TOOLS/include"
MAKEFLAGS="-I$QNX_TARGET/usr/include"
export MAKEFLAGS

QNX_HOST="$NATIVE_TOOLS"
#QNX_CONFIGURATION="$NATIVE_TOOLS/etc/qnxconf"
QCONF_OVERRIDE=$NATIVE_TOOLS/qconf-override.mk
export QNX_HOST QCONF_OVERRIDE

GROFF_FONT_PATH="$NATIVE_TOOLS/share/groff/1.19.2/font:$NATIVE_TOOLS/share/groff/site-font"
GROFF_TMAC_PATH="$NATIVE_TOOLS/share/groff/1.19.2/tmac:$NATIVE_TOOLS/share/groff/site-tmac"
export GROFF_FONT_PATH GROFF_TMAC_PATH

MAGIC="$NATIVE_TOOLS/share/misc/magic.mgc"
export MAGIC

MANPATH="$NATIVE_TOOLS/man:$NATIVE_TOOLS/share/man:$MANPATH"
export MANPATH
alias man='man -C "$NATIVE_TOOLS/lib/man.conf"'

# coreutils
alias ls='ls --color=auto'

# fakeroot
#export FAKEROOTUID=100
#export FAKEROOTGID=100
#export FAKEROOTEUID=100
#export FAKEROOTEGID=100
#export FAKEROOTSUID=100
#export FAKEROOTSGID=100
#export FAKEROOTFUID=100
#export FAKEROOTFGID=100

# locale
export LC_CTYPE=en_US.UTF-8

echo "Berrymuch v0.3\n"
