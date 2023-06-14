DOCKER_OPT=--platform linux/386
DOCKER_OPT_GO=--platform linux/x86_64

build: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch \
		-u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk'

build.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch \
		-u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports/$*; ./build.sh -b /root/bbndk'

build-wip.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch \
		-u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports-wip/$*; ./build.sh -b /root/bbndk'

build-golang.%: docker-image-golang
	docker run $(DOCKER_OPT_GO) \
	  -t -v "${PWD}":/berrymuch \
  	  -u 65534:65534 \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin \
	  -e HOME=/tmp \
	  -e ANDROID_SYSROOT=/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64 \
   	  -e CGO_ENABLED=1 \
   	  -e CGOOS=android \
   	  -e CGARCH=arm \
   	  -e COARM=7 \
	  -e CC=x86_64-linux-android-gcc \
	  android-4.3-ndk:golang /bin/bash -c '\
		source /root/bbndk/bbndk-env_10_3_1_995.sh ;\
		cd /berrymuch/ports-golang/hello-world/  ;\
		export HOME=/tmp ;\
		CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 \
		go build -v  . ; go install'

	  #android-4.3-ndk:golang /bin/bash -c 'cd /berrymuch/ports-golang/$*; go build .'
          
build-debug:
	  #android-4.3-ndk:golang /bin/bash -c 'cd /berrymuch/ports-golang/$*; strace -f -o log go build . ; find / -type f >> log ;  mv log /berrymuch'

	  # -e GOPATH=$HOME/Projects/Proj1 

hello-world:
	uname | egrep -q Linux && ( cd ports-golang/$@ ; CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 strace -v -s 8192 -o log -f go build . ; ls -l log ) || exit 0

	uname | egrep -q Darwin && ( cd ports-golang/$@ ; CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 go build . )
hello-world.baremetal:
	( cd ports-golang/$@ ; CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 strace -v -s 8192 -o log -f go build . ; ls -l log )

hello-world.docker: build-golang.hello-world

hello-world: hello-world.docker

shell: docker-image
	docker run $(DOCKER_OPT) -it \
	  -v "${PWD}":/berrymuch \
  	  -u 65534:65534 \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  yamsergey/bb10-ndk:0.6.3 /bin/bash

gosh: docker-image-golang
	docker run $(DOCKER_OPT_GO) -it \
	  -v "${PWD}":/berrymuch \
  	  -u 65534:65534 \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  	android-4.3-ndk:golang
	  #android-4.3-ndk:golang /bin/bash

docker-image:
	docker build $(DOCKER_OPT) \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg WHOAMI=$(shell whoami) \
		-f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .

docker-image-golang:
	docker build $(DOCKER_OPT_GO) \
		--build-arg UID=65534 \
		--build-arg GID=65534 \
		--build-arg WHOAMI=$(shell whoami) \
		-f Dockerfile.golang -t android-4.3-ndk:golang .
