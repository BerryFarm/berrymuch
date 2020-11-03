FROM i386/ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update
RUN apt-get -yq install \ 
    subversion \
    curl \
    tar \
    gzip \
    bzip2 \
    ruby \
    git \
    subversion \
    curl \
    texinfo \ 
    autopoint \ 
    m4 \ 
    autoconf \
    groff \
    wget \
    libgtk2.0-0 \
    xvfb \
    gcc \
    libxtst6 \
    net-tools \
    lzip \
    g++ \
    zlib1g-dev 

WORKDIR /root

RUN wget http://downloads.blackberry.com/upr/developers/downloads/momentics-2.1.2-201503050937.linux.x86.run 
RUN chmod +x momentics-2.1.2-201503050937.linux.x86.run
RUN yes 'y' | LESS='+q' ./momentics-2.1.2-201503050937.linux.x86.run 
RUN rm momentics-2.1.2-201503050937.linux.x86.run

WORKDIR /root/bbndk
ENV DISPLAY=:1
RUN Xvfb :1 & ./sdkinstall --install 10.3.1.995  

RUN echo "source /root/bbndk/bbndk-env_10_3_1_995.sh" >> /root/.bashrc
RUN echo "export LC_ALL=C" >> /root/.bashrc

RUN apt-get -q update
RUN apt-get -yq install eclipse
RUN apt-get -yq install gtk-chtheme ubuntu-mate-themes fonts-roboto

RUN apt-get -yq install \
    gettext \
    build-essential \
    cmake 

RUN chmod -R 777 /root
