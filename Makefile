build:
	docker run -t -v "${PWD}":/root/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.5.2 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk -t build'

shell: useradd
	docker run -it -v /Big:/Big -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.5.2 /bin/bash

useradd:
	-@docker rm /yamsergey/bb10-ndk:0.5.1 /yam_useradd /yam_groupadd 2> /dev/null
	docker run -it --name yam_groupadd -v "${PWD}":/root/berrymuch yamsergey/bb10-ndk:0.5 /usr/sbin/groupadd kalou --gid $(shell id -g)
	docker commit yam_groupadd yamsergey/bb10-ndk:0.5.1
	docker run -it --name yam_useradd yamsergey/bb10-ndk:0.5.1 /usr/sbin/useradd -M $(shell whoami) --uid $(shell id -u) --gid $(shell id -g) -d /berrymuch
	docker commit yam_useradd yamsergey/bb10-ndk:0.5.2
	touch useradd



