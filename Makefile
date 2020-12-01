SRC_IMG=$(berryamin/bb10-ndk-nox)

build:
	docker run -t -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) berryamin/bb10-ndk-nox:0.1 /bin/bash -c 'cd /berrymuch; ./build.sh -b /root/bbndk -t build'

shell: .useradd
	docker run -it -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) berryamin/bb10-ndk-nox:0.1 /bin/bash

.useradd:
	-@docker rm /berryamin/bb10-ndk-nox:0.1 /yam_useradd /yam_groupadd 2> /dev/null
	docker run -it --name yam_groupadd -v "${PWD}":/root/berrymuch yamsergey/bb10-ndk:0.6 /usr/sbin/groupadd $(shell whoami) --gid $(shell id -g)
	docker commit yam_groupadd berryamin/bb10-ndk-nox:0.1
	docker run -it --name yam_useradd berryamin/bb10-ndk-nox:0.1 /usr/sbin/useradd -M $(shell whoami) --uid $(shell id -u) --gid $(shell id -g) -d /berrymuch
	docker commit yam_useradd yamsergey/bb10-ndk:0.6.2

	touch .useradd

shell: .useradd
	# WIP for import-gcc-5.4.0, TO BE REMOVED in final PR
	#docker run -it -v /Big:/Big -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.2 /bin/bash
	docker run -it -v /opt/qnx800:/opt/qnx800 -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) yamsergey/bb10-ndk:0.6.2 /bin/bash
	docker run -it -v /opt/qnx800:/opt/qnx800 -v "${PWD}":/berrymuch -u $(shell id -u):$(shell id -g) berrymuch:gcc-540 /bin/bash

# WIP for import-gcc-5.4.0, TO BE REMOVED in final PR
rootshell: .useradd
	docker run -it -v /opt/qnx800:/opt/qnx800 -v "${PWD}":/berrymuch berrymuch:gcc-540 /bin/bash

