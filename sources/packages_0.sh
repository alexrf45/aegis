#!/bin/bash

function install_0() {
        sudo apt-get install -y wget curl man git zsh tmux ruby ruby-dev vim nano p7zip-full \
	         djvulibre-bin ldap-utils powershell \
	         python3-pip libpcap-dev jq mousepad \
	         iputils-ping iproute2 proxychains 

}

install_0

