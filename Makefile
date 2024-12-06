
DOCKER_OPT=--platform linux/386

IPFS_SRV=docker run \
	--name ipfsd \
	-v /data/ipfs:/data/ipfs \
	-v /data/kara/berrymuch/ports:/ports \
	 ipfs/go-ipfs

#IPFS=docker exec -t \
IPFS=docker exec -i /ipfsd 
#	-v /data/ipfs:/data/ipfs 
	#-v $(pwd)/ports:/ports 

default:
	cat export.ipfs	

import: export.ipfs
	grep -oE 'Qm\w+ \S+' export.ipfs > cleaned_export.ipfs
	bash -c 'while read hash file; do \
	        wget http://ipfs.io/ipfs/$$hash -O $$file; \
	done < cleaned_export.ipfs'


sh:
	$(IPFS) sh

export: export.ipfs

export.ipfs:
	#docker run --name ipfsd ipfs/go-ipfs
	#docker exec -it /ipfsd sh
	#find . -type f -name \*.zip | xargs -I__ docker exec /ipfsd ipfs add --quiet /__ 
	find . -type f -name \*.zip | xargs -I__ docker exec /ipfsd ipfs add /__ | tee export.ipfs

srv:
	docker rm -f /ipfsd
	$(IPFS_SRV)

build: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk'

build.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports/$*; ./build.sh -b /root/bbndk'

build-wip.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports-wip/$*; ./build.sh -b /root/bbndk'

shell: docker-image
	docker run $(DOCKER_OPT) -it -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash

docker-image:
	docker build $(DOCKER_OPT) --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --build-arg WHOAMI=$(shell whoami) -f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .
