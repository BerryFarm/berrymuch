karawitan@ov-01ac2c:~/berrymuch$ make docker-image-golang && make gosh
docker build --platform linux/x86_64 --build-arg UID=1001 --build-arg GID=1001 --build-arg WHOAMI=karawitan -f Dockerfile.golang -t android-4.3-ndk:golang .

(...)

 > [14/14] RUN go install golang.org/x/mobile/cmd/gomobile@latest:
#0 0.673 go: downloading golang.org/x/mobile v0.0.0-20230531173138-3c911d8e3eda
#0 9.878 go: downloading golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4
#0 9.883 go: downloading golang.org/x/sync v0.0.0-20220819030929-7fc1605a5dde
#0 9.932 go: downloading golang.org/x/tools v0.1.12
#0 10.63 go: downloading golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f
#0 24.18 # golang.org/x/mobile/cmd/gomobile
#0 24.18 loadinternal: cannot find runtime/cgo

[pid   883] execve("/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld", ["/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld", "-pie", "-export-dynamic", "--enable-new-dtags", "--eh-frame-hdr", "-m", "elf_x86_64", "-export-dynamic", "-dynamic-linker", "/system/bin/linker64", "-o", "/tmp/go-build1394615171/b001/exe/a.out", "crtbegin_dynamic.o", "-L/opt/android-ndk-r18b/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/7.0.2/lib/linux/x86_64", "-L/usr/lib/gcc/x86_64-linux-gnu/9", "-L/usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu", "-L/usr/lib/gcc/x86_64-linux-gnu/9/../../../../lib64", "-L/opt/android-ndk-r18b/toolchains/llvm/prebuilt/linux-x86_64/bin/../lib64", "-L/lib/x86_64-linux-gnu", "-L/lib/../lib64", "-L/usr/lib/x86_64-linux-gnu", "-L/usr/lib/../lib64", "-L/usr/lib/x86_64-linux-gnu/../../lib64", "-L/usr/lib/gcc/x86_64-linux-gnu/9/../../..", "-L/lib", "-L/usr/lib", "-z", "relro", "/tmp/go-link-2045914843/go.o", "-lgcc", "-ldl", "-lc", "-lgcc", "-ldl", "crtend_android.o"], ["GOVERSION=go1.17.7", "GIT_SSH_COMMAND=ssh -o ControlMaster=no -o BatchMode=yes", "GOHOSTOS=linux", "PWD=/", "GOARCH=arm", "CXX=g++", "GCCGO=gccgo", "GOARM=7", "HOME=/root", "GOSUMDB=sum.golang.org", "GOROOT=/opt/go", "GOMODCACHE=/opt/go/bin/pkg/mod", "GOTOOLDIR=/opt/go/pkg/tool/linux_amd64", "GOENV=/root/.config/go/env", "AR=ar", "GOPROXY=https://proxy.golang.org,direct", "SHLVL=0", "TOOLEXEC_IMPORTPATH=golang.org/x/mobile/cmd/gomobile", "GOCACHE=/root/.cache/go-build", "GCM_INTERACTIVE=never", "PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin", "CC=x86_64-linux-android-gcc", "CGO_ENABLED=0", "GIT_TERMINAL_PROMPT=0", "GOOS=android", "GOPATH=/opt/go/bin", "GOHOSTARCH=amd64"] <unfinished ...>

execve("/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld"
 ["/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld"
 "-pie"
 "-export-dynamic"
 "--enable-new-dtags"
 "--eh-frame-hdr"
 "-m"
 "elf_x86_64"
 "-export-dynamic"
 "-dynamic-linker"
 "/system/bin/linker64"
 "-o"
 "/tmp/go-build1394615171/b001/exe/a.out"
 "crtbegin_dynamic.o"
 "-L/opt/android-ndk-r18b/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/7.0.2/lib/linux/x86_64"
 "-L/usr/lib/gcc/x86_64-linux-gnu/9"
 "-L/usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu"
 "-L/usr/lib/gcc/x86_64-linux-gnu/9/../../../../lib64"
 "-L/opt/android-ndk-r18b/toolchains/llvm/prebuilt/linux-x86_64/bin/../lib64"
 "-L/lib/x86_64-linux-gnu"
 "-L/lib/../lib64"
 "-L/usr/lib/x86_64-linux-gnu"
 "-L/usr/lib/../lib64"
 "-L/usr/lib/x86_64-linux-gnu/../../lib64"
 "-L/usr/lib/gcc/x86_64-linux-gnu/9/../../.."
 "-L/lib"
 "-L/usr/lib"
 "-z"
 "relro"
 "/tmp/go-link-2045914843/go.o"
 "-lgcc"
 "-ldl"
 "-lc"
 "-lgcc"
 "-ldl"
 "crtend_android.o"]
 ["GOVERSION=go1.17.7"
 "GIT_SSH_COMMAND=ssh -o ControlMaster=no -o BatchMode=yes"
 "GOHOSTOS=linux"
 "PWD=/"
 "GOARCH=arm"
 "CXX=g++"
 "GCCGO=gccgo"
 "GOARM=7"
 "HOME=/root"
 "GOSUMDB=sum.golang.org"
 "GOROOT=/opt/go"
 "GOMODCACHE=/opt/go/bin/pkg/mod"
 "GOTOOLDIR=/opt/go/pkg/tool/linux_amd64"
 "GOENV=/root/.config/go/env"
 "AR=ar"
 "GOPROXY=https://proxy.golang.org
direct"
 "SHLVL=0"
 "TOOLEXEC_IMPORTPATH=golang.org/x/mobile/cmd/gomobile"
 "GOCACHE=/root/.cache/go-build"
 "GCM_INTERACTIVE=never"
 "PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin"
 "CC=x86_64-linux-android-gcc"
 "CGO_ENABLED=0"
 "GIT_TERMINAL_PROMPT=0"
 "GOOS=android"
 "GOPATH=/opt/go/bin"
 "GOHOSTARCH=amd64"] <unfinished ...>


#0 24.18 /opt/go/pkg/tool/linux_amd64/link: running x86_64-linux-android-gcc failed: exit status 1
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: error: cannot open crtbegin_dynamic.o: No such file or directory
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: error: cannot open crtend_android.o: No such file or directory
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libdl.so while searching for dl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /lib/x86_64-linux-gnu/libdl.so while searching for dl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /usr/lib/x86_64-linux-gnu/libdl.so while searching for dl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: error: cannot find -ldl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libc.so while searching for c
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libdl.so while searching for dl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /lib/x86_64-linux-gnu/libdl.so while searching for dl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /usr/lib/x86_64-linux-gnu/libdl.so while searching for dl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: error: cannot find -ldl
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /lib/x86_64-linux-gnu/libc.so while searching for c
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: warning: skipping incompatible /usr/lib/x86_64-linux-gnu/libc.so while searching for c
#0 24.18 /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-ld: error: cannot find -lc
#0 24.18 clang: error: linker command failed with exit code 1 (use -v to see invocation)
#0 24.18
------
Dockerfile.golang:64
--------------------
  62 |     # x86_64-linux-android-gcc is /opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-gcc
  63 |
  64 | >>> RUN go install golang.org/x/mobile/cmd/gomobile@latest
  65 |     #RUN go install golang.org/x/mobile/cmd/gomobile@latest
  66 |
--------------------
ERROR: failed to solve: process "/bin/sh -c go install golang.org/x/mobile/cmd/gomobile@latest" did not complete successfully: exit code: 2
make: *** [Makefile:47: docker-image-golang] Error 1
karawitan@ov-01ac2c:~/berrymuch$


