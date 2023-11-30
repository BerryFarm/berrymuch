
#DOCKER_OPT_GO=--platform linux/amd64
DOCKER_OPT_ANDROID=--platform linux/386
DOCKER_OPT=--platform linux/amd64

default: build-gomobile.syncthing

docker-image.%:
	docker build $(DOCKER_OPT_ANDROID) \
		--build-arg WHOAMI=$(shell whoami) \
		-f Dockerfile.$* -t android-4.3-ndk:$* .

build-gomobile.%: docker-image.gomobile
	docker run -it $(DOCKER_OPT_ANDROID) \
	  -v "${PWD}":/berrymuch \
	  -e HOME=/tmp \
   	  -e CGO_ENABLED=1 \
   	  -e GOOS=android \
   	  -e GOARCH=arm \
   	  -e GOARM=7 \
	  -u $(shell id -u):$(shell id -g) \
   	  -e CGO_LDFLAGS=-llog \
   	  -e CGO_PATH=/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e PATH=/usr/bin:/usr/sbin:/bin:/sbin:/opt/go/bin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e CC=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
	  android-4.3-ndk:gomobile /bin/bash -c '\
		source /root/bbndk/bbndk-env_10_3_1_995.sh && \
	        export PATH=$$PATH:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin:/opt/go/bin:/root/go/bin ; \
		cd /berrymuch/ports-gomobile/$* &&\
		export HOME=/tmp ; echo $$PATH &&\
		gomobile init ; go build -x -n  . && go install && file /tmp/go/bin/hello-world '

build-android-wip.%: docker-image.android
	docker run -it $(DOCKER_OPT_ANDROID) \
	  -v "${PWD}":/berrymuch \
	  -e HOME=/tmp \
	  -e PATH=/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e CC=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
	  android-4.3-ndk:android /bin/bash -c '\
		source /root/bbndk/bbndk-env_10_3_1_995.sh && \
	        export PATH=$$PATH:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin ; \
		cd /berrymuch/ports-android-wip/$* &&\
		export HOME=/tmp ; echo $$PATH &&\
		./build.sh '


droidsh: docker-image.gomobile
	docker run -it $(DOCKER_OPT_ANDROID) \
          -v "${PWD}":/berrymuch \
          -e HOME=/tmp \
          -e PATH=/usr/bin:/usr/sbin:/bin:/sbin:/opt/go/bin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
          -e CC=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
         android-4.3-ndk:android \
		/bin/bash 

         #-u $(shell id -u):$(shell id -g) \

gosh: docker-image.gomobile
	docker run -it $(DOCKER_OPT_GO) \
	  -v "${PWD}":/berrymuch \
	  -e HOME=/tmp \
   	  -e CGO_ENABLED=1 \
   	  -e GOOS=android \
   	  -e GOARCH=arm \
   	  -e GOARM=7 \
	  #-u $(shell id -u):$(shell id -g) \
   	  -e CGO_LDFLAGS=-llog \
   	  -e CGO_PATH=/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e PATH=/usr/bin:/usr/sbin:/bin:/sbin:/opt/go/bin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  -e CC=arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 \
	  android-4.3-ndk:android "/bin/bash \
	  	export PATH=$$PATH:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin ; \
	  	export PATH=$$PATH:/opt/go/bin:/root/go/bin ; \
		source /root/bbndk/bbndk-env_10_3_1_995.sh ; \
		bash \
 	   '


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


syncthing:
	uname | egrep -q Linux && ( cd ports-android/$@ ; CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 strace -v -s 8192 -o log -f go build . ; ls -l log ) || exit 0

	uname | egrep -q Darwin && ( cd ports-android/$@ ; CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 go build . )
hello-world.baremetal:
	( cd ports-golang/$@ ; CGO_ENABLED=1 GOOS=android GOARCH=arm GOARM=7 strace -v -s 8192 -o log -f go build . ; ls -l log )


gosh.root: docker-image.gomobile
	docker run $(DOCKER_OPT_GO) -it \
	  -v "${PWD}":/berrymuch \
	  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
	  	android-4.3-ndk:gomobile


docker-image:
	docker build $(DOCKER_OPT) \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg WHOAMI=$(shell whoami) \
		-f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .

