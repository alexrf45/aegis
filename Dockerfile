# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "author"="Sean Fontaine"
LABEL "version"="1.0"

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
	python3-pip

RUN apt-get update && apt-get install -y \
	netcat-traditional \
	nmap \
	inetutils-tools \
	iputils-ping \
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
	wordlists

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

RUN mkdir .logs

RUN git clone https://github.com/samratashok/nishang.git

RUN mkdir tools && cd tools/ && \
	git clone https://github.com/fleetcaptain/Turbolist3r.git && cd Turbolist3r/ && \
	pip install -r requirements.txt

RUN cd tools/ && git clone https://github.com/jordanpotti/CloudScraper && cd CloudScraper/ && pip install -r requirements.txt

RUN cd tools/ && \
	wget -q -O pspy https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s && \
	wget -q -O l.sh https://github.com/carlospolop/PEASS-ng/releases/download/20221106/linpeas.sh && \
	wget -q -O winpeas.exe https://github.com/carlospolop/PEASS-ng/releases/download/20221106/winPEASx64.exe && \
	wget -q -O sharp.ps1 https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1 && \
	wget -q -O netcat https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe

COPY resources/tmux.conf .tmux.conf

COPY resources/recon.sh recon.sh

COPY resources/slackcat slackcat

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

COPY resources/zsh/zshrc .zshrc

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN cp .zshrc .zlogin && touch ~/.hushlogin

COPY resources/zsh/aussiegeek.zsh-theme /root/.oh-my-zsh/themes/.

COPY resources/zsh/kali_history /root/.kali_history

RUN rm -rf /etc/localtime 

RUN ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

CMD zsh



