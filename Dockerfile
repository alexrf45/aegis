# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "author"="Sean Fontaine"
LABEL "version"="1.03"
LABEL "website"="https://r0land.link"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	wget \
	curl \
	man \
	sudo \
	git  \
	zsh  \
	tmux \
	ruby \
	vim  \
	nano \
	python3-pip \
	libpcap-dev \
	jq \
	mousepad

RUN apt-get update && apt-get install -y \
	netcat-traditional \
	nmap \
	netdiscover \
	inetutils-tools \
	iputils-ping \
	iproute2 \
	ftp \
	proxychains \
	telnet \
	swaks \
	snmpcheck \
	snmpenum \
	snmp-mibs-downloader \
	masscan \
	httprobe \
	dnsenum  \
	dnsutils \
	amass \
	wireshark

RUN apt-get install -y \
	whatweb \
	ffuf \
	seclists \
	sqlmap \
	john \
	exiftool \
	djvulibre-bin \
	crunch \
	hydra \
	wordlists \
	burpsuite

RUN apt-get install -y \
	python3-impacket \
	smbclient \
	crackmapexec \
	smbmap \
	ruby \
	ruby-dev \
	evil-winrm \
	impacket-scripts \
	nuclei \
	hakrawler \
	ldap-utils \
	powershell \
	bloodhound \
	rlwrap

WORKDIR /root

ADD sources /root/sources/

ADD resources /root/resources/

RUN mkdir .logs && mkdir .local && mkdir tools \
	&& cp /root/resources/config.ini /root/.local/config.ini \
	&& cp /root/resources/tmux.conf /root/.tmux.conf \
	&& cp /root/resources/recon.sh /root/.local/recon.sh \
	&& cp /root/resources/resolvers.txt /root/tools/resolvers.txt \
	&& cp /root/resources/ffufrc /root/.ffufrc \
	&& cp /root/resources/ffufrc_subdomain /root/.ffufrc_subdomain \
	&& cp -r /root/resources/.BurpSuite /root/.BurpSuite

RUN chmod +x /root/sources/python.sh \
	&& chmod +x /root/sources/go.sh \
	&& chmod +x /root/sources/tools.sh \
	&& git clone https://github.com/samratashok/nishang.git

RUN /root/sources/python.sh python_tools

RUN /root/sources/go.sh install_go

RUN /root/sources/tools.sh tools_install

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN cp /root/resources/zsh/ka-tet.zsh-theme /root/.oh-my-zsh/themes/. \
	&& cp /root/resources/zsh/kali_history /root/.kali_history \
	&& cp /root/resources/zsh/zshrc /root/.zshrc 

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
	&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN rm -rf /root/sources && rm -rf /root/resources

CMD zsh



