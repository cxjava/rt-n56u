FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
	&& apt-get install -qy --no-install-recommends automake autopoint bison build-essential ca-certificates cmake cpio curl fakeroot flex gawk gettext git git-core gperf help2man libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libssl-dev libtool libtool-bin mc module-init-tools nano p7zip-full pkg-config python-docutils texinfo unzip vim wget xxd zlib1g-dev \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV LC_ALL en_US.UTF-8

WORKDIR /opt

CMD ["/build.sh"]