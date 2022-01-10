FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp

RUN apt-get -yqq update \    
    && apt-get install --no-install-recommends -yqq python-is-python3 pigz tar rsync rclone aria2 libncurses5 adb autoconf automake axel bc bison build-essential ccache clang cmake curl expat fastboot flex g++ g++-multilib gawk gcc gcc-multilib git gnupg gperf htop imagemagick locales libncurses5 lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml-simple-perl libxml2 libxml2-utils lsb-core lzip '^lzma.*' lzop maven nano ncftp ncurses-dev openssh-server patch patchelf pkg-config pngcrush pngquant python2.7 python-all-dev python-is-python3 re2c rclone rsync schedtool squashfs-tools subversion sudo tar texinfo tmate tzdata unzip w3m wget xsltproc zip zlib1g-dev zram-config zstd \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo && sudo chmod a+rx /usr/local/bin/repo

RUN groupadd -g 1000 -r stealth && \
    useradd -u 1000 --create-home -r -g stealth stealth && \
    mkdir -p /tmp/ccache && \
    chown -R stealth: /tmp/ccache

RUN echo "stealth ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-docker-build && \
    usermod -aG sudo stealth

USER stealth
VOLUME ["/tmp/ccache"]

RUN git config --global user.name Stealth1226 && git config --global user.email rishawniyer06@gmail.com && \
    git config --global color.ui auto 


ENTRYPOINT ["/bin/bash"]
