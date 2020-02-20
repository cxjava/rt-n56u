FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
	&& apt-get -y update \
	&& apt-get install -qy apt-utils \
	&& apt-get -qy install locales \
	&& locale-gen --no-purge en_US.UTF-8 \
	&& apt-get install -qy --no-install-recommends asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ca-certificates cmake cpio curl device-tree-compiler flex gawk gcc-multilib gettext gita git-core gperf help2man htop lib32gcc1 libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libssl-dev libtool libtool-bin libz-dev mc msmtp nano p7zip p7zip-full patch pkg-config python-docutils qemu-utils rsync screen subversion sudo texinfo uglifyjs unzip upx vim wget xmlto xxd zlib1g-dev zsh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd -m admin \
	&& echo admin:admin | chpasswd \
	&& echo 'admin ALL=NOPASSWD: ALL' > /etc/sudoers.d/admin \
	&& cd /home/admin \
	&& git clone git://github.com/robbyrussell/oh-my-zsh ./.oh-my-zsh \
	&& cp /home/admin/.oh-my-zsh/templates/zshrc.zsh-template ./.zshrc \
	&& git clone git://github.com/zsh-users/zsh-syntax-highlighting ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
	&& git clone git://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions \
	&& sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' .zshrc \
	&& sed -i 's/plugins=(git)/plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions)/g' .zshrc \
	&& sed -i 's/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/g' .zshrc \
	&& chown -R admin:admin /home/admin \
	&& mkdir -p /opt \
	&& chown -R admin:admin /opt \
	&& cp -R ./.oh-my-zsh/ /root/ \
	&& cp ./.zshrc /root \
	&& sed -i 's/\/home\/admin:/\/home\/admin:\/bin\/zsh/g' /etc/passwd \
	&& echo "Asia/Shanghai" > /etc/timezone

ENV LC_ALL en_US.UTF-8

USER admin
WORKDIR /home/admin

CMD ["/build.sh"]
