#!/bin/bash

function install_2 () {
    sudo apt-get install -y whatweb ffuf gobuster nuclei \
	seclists wordlists crunch \
	sqlmap john exiftool hydra python3-impacket impacket-scripts \
	smbclient smbmap crackmapexec evil-winrm bloodhound
}

install_2