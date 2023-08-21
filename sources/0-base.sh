#!/bin/bash

base() {
	sudo apt-get install -y wget curl man git zsh \
		tmux ruby ruby-dev vim nano p7zip-full kali-themes \
		djvulibre-bin python3-pip python3-virtualenv libpcap-dev jq \
		firefox-esr xpdf tmuxp
}

network() {
	sudo apt-get install -y netcat-traditional socat rlwrap nmap \
		netdiscover masscan dnsutils onesixtyone braa tcpdump \
		ftp telnet swaks snmpcheck snmpcheck snmp-mibs-downloader \
		iputils-ping iproute2 proxychains sendmail
}

active_directory() {
	sudo apt-get install -y \
		smbclient smbmap evil-winrm bloodhound responder \
		powershell ldap-utils
}

echo -e "Installing base packages"
base
echo -e "Installing network packages"
network
echo -e "Installing AD tools"
active_directory
#echo -e "Installing web tools"
#web
#echo -e "Installing password tools"
#password

#sublime install
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg |
	gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg >/dev/null

echo "deb https://download.sublimetext.com/ apt/stable/" |
	sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update

sudo apt-get install sublime-text
