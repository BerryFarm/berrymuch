DOCKER_OPT=--platform linux/386

build: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk'

build.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports/$*; ./build.sh -b /root/bbndk'

build-wip.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports-wip/$*; ./build.sh -b /root/bbndk'

build-golang.%:
	( cd ports-golang/$*; CGO_ENABLED=0 GOOS=android GOARCH=arm GOARM=7 go build . )

shell: docker-image
	docker run $(DOCKER_OPT) -it -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash

docker-image:
	docker build $(DOCKER_OPT) --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --build-arg WHOAMI=$(shell whoami) -f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .
