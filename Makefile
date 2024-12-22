
DOCKER_OPT=--platform linux/386

IPFS_VOLUMES=\
	-v /data/ipfs:/data/ipfs \
	-v /data/kara/berrymuch:/berrymuch \
	-v /data/kara/berrymuch/scratch:/berrymuch/scratch \

IPFS_SRV=docker run \
	--name ipfsd \
	$(IPFS_VOLUMES) \
	 ipfs/go-ipfs

IPFS=docker exec -it /ipfsd 

default:
	cat export.ipfs	

import: export.ipfs
	grep -oE 'Qm\w+ \S+' export.ipfs > cleaned_export.ipfs
	bash -c 'while read hash file; do \
	        wget http://ipfs.io/ipfs/$$hash -O $$file; \
	done < cleaned_export.ipfs'

sh.ipfs:
	$(IPFS) sh


TARGET_PKGS=$(shell cd packages ; ls *zip | sed -e 's/.zip$$//g' )
#TARGET_PKGS=$(shell cd packages ; ls *zip | sed -e 's/.zip$$//g' | head -3)
TARGET_PKGS_IPFS=$(foreach pkg, $(TARGET_PKGS), $(pkg).pkg_ipfs)

export: export.ipfs

export.ipfs:
	for z in $(shell find packages/ -type f -name \*.zip ); \
	do \
	  echo -n "/berrymuch/$$z " ;\
	  docker exec /ipfsd /usr/local/bin/ipfs add --quiet -n /berrymuch/$$z ; \
	done \
	>> scratch/export.ipfs; \

packages.ipfs: $(TARGET_PKGS_IPFS)


%.pkg_ipfs: 
	find packages/ -type d  -printf "%n %p\n" | \
	awk '($$1<=2) { print $$2 }' | \
	xargs -n 1 docker exec -w /berrymuch /ipfsd ipfs add --quiet -r \
	 >> scratch/export.$(*).ipfs

dum:
	find packages/ -type d  | xargs stat -t | \
		awk '($$9==2) { print $$1 } ' |  \
		xargs -P 12 -n 1 docker exec -w /berrymuch /ipfsd ipfs add --quiet -r  \
	>> scratch/export.$.ipfs

		 #xargs -P 12 -n 1 docker exec -w /berrymuch /ipfsd ipfs add --quiet -r  \


%:
	@-unzip -qo $*.zip -d $* 2> /dev/null

srv:
	docker rm -f /ipfsd
	$(IPFS_SRV)

build: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk'

build.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) --name build_$* yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports/$*; ./build.sh -b /root/bbndk'

build-wip.%: docker-image
	docker run $(DOCKER_OPT) -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash -c 'cd /berrymuch/ports-wip/$*; ./build.sh -b /root/bbndk'

shell: docker-image
	docker run $(DOCKER_OPT) -it -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.3 /bin/bash

docker-image:
	docker build $(DOCKER_OPT) --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) --build-arg WHOAMI=$(shell whoami) -f Dockerfile.karawitan -t yamsergey/bb10-ndk:0.6.3 .

strip_all:
	/usr/bin/find . -type f | grep -E "bin/|lib/lib.*.so.*" | xargs /root/bbndk/host_10_3_1_12/linux/x86/usr/bin/arm-unknown-nto-qnx8.0.0eabi-strip-2.24 2> /dev/null ; /bin/true
