#!/bin/bash

base() {
	sudo apt-get install -y wget curl man git zsh \
		tmux ruby ruby-dev vim nano p7zip-full kali-themes \
		djvulibre-bin python3-pip python3-virtualenv libpcap-dev jq \
		firefox-esr xpdf tmuxp man-db exploitdb
}

network() {
	sudo apt-get install -y netcat-traditional socat rlwrap nmap \
		netdiscover masscan dnsutils onesixtyone braa tcpdump \
		ftp telnet swaks snmpcheck snmpcheck snmp-mibs-downloader \
		iputils-ping iproute2 proxychains sendmail ltrace
}

active_directory() {
	sudo apt-get install -y \
		smbclient smbmap evil-winrm bloodhound responder \
		powershell ldap-utils
}

base
network
active_directory
