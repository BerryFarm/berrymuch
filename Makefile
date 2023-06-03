DOCKER_OPT=--platform linux/386
DOCKER_OPT_GO=--platform linux/x86_64

build: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk'

build.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports/$*; ./build.sh -b /root/bbndk'

build-wip.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports-wip/$*; ./build.sh -b /root/bbndk'

build-golang.%: docker-image-golang
	docker run $(DOCKER_OPT_GO) \
	  -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/android-ndk-r18b/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin \
	  -e HOME=/berrymuch/ports-golang/$* \
	  android-4.3-ndk:golang /bin/bash -c 'cd /berrymuch/ports-golang/$*; strace -f -o log go build . ; find / -type f >> log ;  mv log /berrymuch'
	  #android-4.3-ndk:golang /bin/bash -c 'cd /berrymuch/ports-golang/$*; go build .'
	  #yamsergey/bb10-ndk:golang /bin/bash -c 'source /root/bbndk/bbndk-env_10_3_1_995.sh; cd /berrymuch/ports-golang/$*; strace -f -o log go build . ; mv log /berrymuch'

	  # -e GOPATH=$HOME/Projects/Proj1 

shell: docker-image
	docker run $(DOCKER_OPT) -it \
	  -v "${PWD}":/berrymuch \
	  -u $(shell id -u):$(shell id -g) \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  yamsergey/bb10-ndk:0.6.3 /bin/bash

gosh: docker-image-golang
	docker run $(DOCKER_OPT_GO) -it \
	  -v "${PWD}":/berrymuch \
	  -u $(shell id -u):$(shell id -g) \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  android-4.3-ndk:golang /bin/bash

docker-image:
	docker build $(DOCKER_OPT) --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --build-arg WHOAMI=$(shell whoami) -f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .

docker-image-golang:
	docker build $(DOCKER_OPT_GO) --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --build-arg WHOAMI=$(shell whoami) -f Dockerfile.golang -t android-4.3-ndk:golang .
