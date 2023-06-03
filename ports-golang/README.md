
TODO ( work in progress )

Build a Docker environment for golang cross compilation for arm

###

Latest error hit:

karawitan@ov-01ac2c:~/berrymuch$ make build-golang.hello-world
docker build --platform linux/386 --build-arg UID=1001 --build-arg GID=1001 --build-arg WHOAMI=karawitan -f Dockerfile.golang -t yamsergey/bb10-ndk:golang .
[+] Building 0.8s (9/9) FINISHED
 => [internal] load build definition from Dockerfile.golang                                                                                                                                                    0.0s
 => => transferring dockerfile: 744B                                                                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                                                              0.0s
 => => transferring context: 98B                                                                                                                                                                               0.0s
 => [internal] load metadata for docker.io/yamsergey/bb10-ndk:0.6                                                                                                                                              0.8s
 => [auth] yamsergey/bb10-ndk:pull token for registry-1.docker.io                                                                                                                                              0.0s
 => [1/4] FROM docker.io/yamsergey/bb10-ndk:0.6@sha256:ab2f7a53011ec7792c8a7bb6ec63dcfd3d124d7fe55463cc25069b2f7e37a273                                                                                        0.0s
 => CACHED [2/4] RUN apt-get -y update ; apt-get -y install sudo                                                                                                                                               0.0s
 => CACHED [3/4] RUN wget https://dl.google.com/go/go1.17.7.linux-386.tar.gz                                                                                                                                   0.0s
 => CACHED [4/4] RUN sudo mkdir /opt ;    sudo tar -xvf go1.17.7.linux-386.tar.gz -C /opt ;    rm go1.17.7.linux-386.tar.gz                                                                                    0.0s
 => exporting to image                                                                                                                                                                                         0.0s
 => => exporting layers                                                                                                                                                                                        0.0s
 => => writing image sha256:5f9e2da2ff85f5724707809ff110e138597b119339a874eec59fa216dd197658                                                                                                                   0.0s
 => => naming to docker.io/yamsergey/bb10-ndk:golang                                                                                                                                                           0.0s
docker run --platform linux/386 \
  -t -v "/home/karawitan/berrymuch":/berrymuch -u 1001:1001 \
  -e PATH=/opt/go/bin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bbndk/host_10_3_1_12/linux/x86/usr/bin \
  -e HOME=/berrymuch/ports-golang/hello-world \
  yamsergey/bb10-ndk:golang /bin/bash -c 'source /root/bbndk/bbndk-env_10_3_1_995.sh; cd /berrymuch/ports-golang/hello-world; go build .'
# hello-world
loadinternal: cannot find runtime/cgo
/opt/go/pkg/tool/linux_386/link: running arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3 failed: exit status 1
arm-unknown-nto-qnx8.0.0eabi-gcc-4.6.3: error: unrecognized option '-rdynamic'

docker build --platform linux/x86_64 --build-arg UID=1001 --build-arg GID=1001 --build-arg WHOAMI=karawitan -f Dockerfile.golang -t android-4.3-ndk:golang .
