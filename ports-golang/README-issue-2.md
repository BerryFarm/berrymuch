m1:berrymuch v0.5-rc2-30-g0b363468e 🌘 kalou  make build-golang.hello-world
( cd ports-golang/hello-world; CGO_ENABLED=0 GOOS=android GOARCH=arm GOARM=7 go build . )
# hello-world
loadinternal: cannot find runtime/cgo
/usr/local/go/pkg/tool/darwin_arm64/link: running clang failed: exit status 1
ld: unknown option: -z
clang: error: linker command failed with exit code 1 (use -v to see invocation)

make: *** [build-golang.hello-world] Error 1

m1:berrymuch v0.5-rc2-30-g0b363468e 🌘 kalou git status
On branch ports-golang
Your branch is up to date with 'origin/ports-golang'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.lesshst
	HEAD_650/
	README-import-pkgsrc.txt
	android_file_urls.txt
	author.p12
	bin/
	core/
	doc/HOWTO-install-bar-applications-in-2022.md
	gentoken.sh
	master/
	mk/
	ports-golang/README-android-sdk.md
	ports/mdns/

nothing added to commit but untracked files present (use "git add" to track)
m1:berrymuch v0.5-rc2-30-g0b363468e 🌘 kalou git describe
v0.5-rc2-30-g0b363468e
