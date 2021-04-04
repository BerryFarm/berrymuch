build: docker-image
	docker run -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.2 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk -t build'

shell: docker-image
	docker run -it -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.2 /bin/bash

docker-image:
	docker build --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --build-arg WHOAMI=$(shell whoami) -f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.2 .
