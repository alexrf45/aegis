#!/bin/bash

web() {
	sudo apt-get install -y whatweb ffuf sqlmap \
		exiftool default-mysql-client hurl postgresql arjun sqsh
}

snyk-cli() {
	curl --compressed https://static.snyk.io/cli/latest/snyk-linux -o snyk &&
		chmod +x ./snyk && mv ./snyk $HOME/.local/bin/snyk
}

password() {
	sudo apt-get install -y crunch
}

install_go() {
	wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz &&
		sudo rm -rf /usr/local/go &&
		tar -C $HOME/.local/bin -xzf go1.21.6.linux-amd64.tar.gz &&
		rm go1.21.6.linux-amd64.tar.gz
}

payload() {
	cd $HOME/tools/ &&
		wget -q -O nc.exe \
			"https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe" &&
		wget -q -O nc \
			"https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/ncat"
}

active_directory() {
	cd $HOME/tools/ &&
		wget -q -O rubeus.exe \
			"https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe" &&
		wget -q -O certify.exe \
			"https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Certify.exe" &&
		wget "https://github.com/fortra/impacket/releases/download/impacket_0_11_0/impacket-0.11.0.tar.gz" &&
		gunzip impacket-0.11.0.tar.gz && tar -xvf impacket-0.11.0.tar &&
		mv impacket-0.11.0/ /home/kali/.local/ && rm impacket-0.11.0.tar &&
		wget -q -O sharp.ps1 \
			"https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1" &&
		wget -q -O SharpHound.exe \
			"https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.exe" &&
		wget -q -O netexec \
			"https://github.com/Pennyw0rth/NetExec/releases/download/v1.1.0/nxc" &&
		chmod +x netexec && sudo mv netexec /home/kali/.local/bin/netexec
}

pivot() {
	cd $HOME/tools/ &&
		wget -q -O chisel.gz \
			"https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_linux_amd64.gz" &&
		gunzip chisel.gz &&
		wget -q -O win-chisel.gz \
			"https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_windows_amd64.gz" &&
		gunzip win-chisel.gz
}

privesc() {
	cd $HOME/tools/ &&
		wget -q -O linpeas \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20231029-83b8fbe1/linpeas_linux_amd64" &&
		wget -q -O winpeas.exe \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20231029-83b8fbe1/winPEASany.exe" &&
		wget -q -O pspys \
			"https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s" &&
		wget -q -O pspy \
			"https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64"
}

web
install_go
password
payload
active_directory
pivot
privesc
