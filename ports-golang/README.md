https://go.dev/doc/contribute
https://go.dev/doc/contribute#checkout_go


go build: when using gc toolchain, please pass compile flags using -gcflags, and linker flags using -ldflags


TODO ( work in progress )

Build a Docker environment for golang cross compilation for GOOS/GOARCH qnx/arm GOARM=7

What about QNX golang support ?
https://groups.google.com/g/golang-nuts/c/1gIqyz1fGJo

Konstantin Khomoutov
2 Dec 2016, 16:56:15
to Yuriy Yarosh, golang-nuts
There exists a document describing a policy of porting Go to a new
platform [1]. If you're OK with the requirement, you can bring this
question on the golang-dev mailing list.

1. https://github.com/golang/go/wiki/PortingPolicy


QNX Neutrino OS Guides > System Architecture > Dynamic Linking
How shared objects are used
To understand how a program makes use of shared objects, let's first see the format of an executable and then examine the steps that occur when the program starts.

ELF format

http://www.qnx.com/developers/docs/qnxcar2/index.jsp?topic=%2Fcom.qnx.doc.neutrino.sys_arch%2Ftopic%2Fdll_HOWUSED.html

###

Latest error hit:

While trying to cross-compile hello-world.go for berrymuch, I hit the following issue

https://stackoverflow.com/questions/67435581/golang-cgo-android-ndk-missing-pthread/76509676#76509676

This may be reproduced like this:

git clone https://github.com/BerryFarm/berrymuch.git --branch ports-golang --depth=1
make build-golang.hello-world


Any hint would be greatly appreciated at this point 🙂

extrowerk, [20 Jun 2023 at 23:10:28]:
-pthread is a linker flag for systems where the posix thread support resides in the libpthread library. It seems QNX doesn't have this lib or it named differently. For example on Haiku the pthread functions always linked in unconditionally, therefore the solution for this kind of errors is simply: remove the -pthread flag.

So i would recommend you to check where the pthread stuff lives on QNX

pthread_create
Create a thread

Yeah, it is in libc on QNX: https://www.qnx.com/developers/docs/6.5.0SP1.update/com.qnx.doc.neutrino_lib_ref/p/pthread_create.html

Library:
libc
Use the -l c option to qcc to link against this library. This library is usually included automatically.

Karvidov, [20 Jun 2023 at 23:13:30 (20 Jun 2023 at 23:13:45)]:
ok ! so find a way to trigger use -lc instead of -lpthread  🙂

extrowerk, [20 Jun 2023 at 23:19:49]:
grep the sources :)

it should be in a makefile, or m4 file, or in config file, or in cmake file, or in similar stuff

Karvidov, [20 Jun 2023 at 23:21:58]:
[resolved] failed to cross-compile QNX on ubuntu16 · Issue #2486 · eclipse/mosquitto
When I cross-compiled the library on ubuntu16.04, I could not find -lpthread and -ldl when linking, causing the build to fail. After a period of investigation, I found that the following codes were...

Karvidov, [20 Jun 2023 at 23:21:58]:
hmm good advice . Probably my issue might have similarities with https://github.com/eclipse/mosquitto/issues/2486

Thanks a lot ! I’ll keep you up to date about this exciting topic 🙂
