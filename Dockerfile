# latest kali base image
FROM kalilinux/kali-rolling:latest

LABEL "author"="Sean Fontaine"
LABEL "version"="v0.0.2"
LABEL "website"="https://r0land.link"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	wget curl man sudo git zsh tmux ruby ruby-dev vim nano \
	djvulibre-bin ldap-utils powershell \
	python3-pip libpcap-dev jq mousepad \
	iputils-ping iproute2 proxychains

RUN apt-get update && apt-get install -y \
	netcat-traditional rlwrap nmap netdiscover masscan \
	httprobe wireshark dnsenum dnsutils amass\
	ftp telnet swaks snmpcheck snmpcheck snmp-mibs-downloader
	
RUN apt-get install -y \
	whatweb ffuf burpsuite nuclei \
	seclists wordlists crunch \
	sqlmap \
	john exiftool hydra

RUN apt-get install -y \
	python3-impacket impacket-scripts \
	smbclient smbmap \
	crackmapexec evil-winrm bloodhound

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
	&& /root/sources/python.sh python_tools \
	&& chmod +x /root/sources/go.sh \
	&& /root/sources/go.sh install_go \
	&& chmod +x /root/sources/tools.sh \
	&& /root/sources/tools.sh tools_install \
	&& git clone https://github.com/samratashok/nishang.git

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
	--unattended

RUN cp /root/resources/zsh/ka-tet.zsh-theme /root/.oh-my-zsh/themes/. \
	&& cp /root/resources/zsh/kali_history /root/.kali_history \
	&& cp /root/resources/zsh/zshrc /root/.zshrc \
	&& git clone https://github.com/zsh-users/zsh-autosuggestions \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
	&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN rm -rf /root/sources && rm -rf /root/resources

CMD zsh



