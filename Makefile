
#DOCKER_OPT_GO=--platform linux/amd64
DOCKER_OPT_GO=--platform linux/386
DOCKER_OPT=--platform linux/amd64

default: build-golang.hello-world

#default: docker-image-golang

build: docker-image
	docker run $(DOCKER_OPT) -t \
		-v "${PWD}":/berrymuch \
		-u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash \
		-c 'cd /berrymuch; ./build.sh -b /root/bbndk'

build.%: docker-image
	docker run $(DOCKER_OPT) -t \
		-v "${PWD}":/berrymuch \
		-u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash \
		-c 'cd /berrymuch/ports/$*; ./build.sh -b /root/bbndk'

build-wip.%: docker-image
	docker run $(DOCKER_OPT) -t \
		-v "${PWD}":/berrymuch \
		-u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash \
		-c 'cd /berrymuch/ports-wip/$*; ./build.sh -b /root/bbndk'

  	  #-u 65534:65534 

build-golang.%: docker-image-golang
	docker run -it $(DOCKER_OPT_GO) \
	  -t -v "${PWD}":/berrymuch \
	  -u $(shell id -u):$(shell id -g) \
	  -e HOME=/tmp \
   	  -e CGO_ENABLED=1 \
   	  -e GOOS=android \
   	  -e GOARCH=arm \
   	  -e GOARM=7 \
   	  -e CGO_LDFLAGS=-llog \
	  -e PATH=/usr/bin:/usr/sbin:/bin:/sbin:/opt/go/bin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e CC=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
	  -e CC_FOR_TARGET=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
	  android-4.3-ndk:golang /bin/bash \
		-c '\
		source /root/bbndk/bbndk-env_10_3_1_995.sh &&\
		cd /berrymuch/ports-golang/hello-world/  &&\
		export HOME=/tmp &&\
		strace -v -s 8192 -f -o /berrymuch/log go build -x  . && go install && file /tmp/go/bin/hello-world '

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
	docker run -it $(DOCKER_OPT_GO) \
	  -t -v "${PWD}":/berrymuch \
  	  -u 65534:65534 \
	  -e HOME=/tmp \
   	  -e CGO_ENABLED=1 \
   	  -e GOOS=android \
   	  -e GOARCH=arm \
   	  -e GOARM=7 \
   	  -e CGO_LDFLAGS=-llog \
	  -e PATH=/usr/bin:/usr/sbin:/bin:/sbin:/opt/go/bin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e CC=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
	  android-4.3-ndk:golang /bin/bash -c '\
		source /root/bbndk/bbndk-env_10_3_1_995.sh ; \
		bash \
	  '

gosh.root: docker-image-golang
	docker run $(DOCKER_OPT_GO) -it \
	  -v "${PWD}":/berrymuch \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  	android-4.3-ndk:golang

docker-image-golang:
	docker build $(DOCKER_OPT_GO) \
		--build-arg WHOAMI=$(shell whoami) \
		-f Dockerfile.golang -t android-4.3-ndk:golang .
		#--build-arg UID=65534 \
		#--build-arg GID=65534 \

docker-image:
	docker build $(DOCKER_OPT) \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg WHOAMI=$(shell whoami) \
		-f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .

