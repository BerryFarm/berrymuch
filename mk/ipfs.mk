
IPFS_VOLUMES=\
        -v /data/ipfs:/data/ipfs \
        -v /data/kara/berrymuch:/berrymuch \
        -v /data/kara/berrymuch/scratch:/berrymuch/scratch \

IPFS_SRV=docker run \
        --name ipfsd \
        $(IPFS_VOLUMES) \
         ipfs/go-ipfs

TARGET_PKGS=$(shell mkdir -p packages; cd packages ; ls *zip 2> /dev/null | sed -e 's/.zip$$//g' )
TARGET_PKGS_IPFS=$(foreach pkg, $(TARGET_PKGS), $(pkg).pkg_ipfs)

IPFS=docker exec -it /ipfsd

default: export.ipf
	cat export.ipfs

ipfs_get.%:
	$(IPFS) get "$*" > $*

ipfs.srv:
	docker rm -f /ipfsd
	$(IPFS_SRV)

DOCKER_OPT=--platform linux/386


import: export.ipfs
	grep -oE 'Qm\w+ \S+' export.ipfs > cleaned_export.ipfs
	bash -c 'while read hash file; do \
	        wget -nc http://ipfs.io/ipfs/$$hash -O $$file; \
	done < cleaned_export.ipfs'

sh.ipfs:
	$(IPFS) sh

export: export.ipfs

export.ipfs:
	for z in $(shell find packages/ -type f -name \*.zip ); \
	do \
	  echo -n "/berrymuch/$$z " ;\
	  docker exec /ipfsd /usr/local/bin/ipfs add --quiet -n /berrymuch/$$z ; \
	done \
	>> scratch/$@;

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

