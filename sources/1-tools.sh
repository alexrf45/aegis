#!/bin/bash

web() {
	sudo apt-get install -y whatweb ffuf sqlmap \
		exiftool default-mysql-client hurl postgresql arjun \
		burpsuite
}

snyk-cli() {
	curl --compressed https://static.snyk.io/cli/latest/snyk-linux -o snyk &&
		chmod +x ./snyk && mv ./snyk $HOME/.local/.
}

password() {
	sudo apt-get install -y seclists crunch
}

install_go() {
	wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz &&
		rm -rf /usr/local/go &&
		sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz &&
		rm go1.21.1.linux-amd64.tar.gz
}

httpx_install() {
	wget -q https://github.com/projectdiscovery/httpx/releases/download/v1.3.5/httpx_1.3.5_linux_amd64.zip &&
		unzip httpx_1.3.5_linux_amd64.zip -d ./httpx &&
		rm httpx_1.3.5_linux_amd64.zip &&
		mv httpx/httpx /home/kali/.local/http-x &&
		rm -r httpx/

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
		wget -q -O cme.zip \
			"https://github.com/Porchetta-Industries/CrackMapExec/releases/download/v5.4.0/cme-ubuntu-latest-3.11.zip" &&
		unzip cme.zip && chmod +x cme && sudo mv cme /home/kali/.local/cme && rm cme.zip &&
		wget "https://github.com/fortra/impacket/releases/download/impacket_0_11_0/impacket-0.11.0.tar.gz" &&
		gunzip impacket-0.11.0.tar.gz && tar -xvf impacket-0.11.0.tar &&
		mv impacket-0.11.0/ /home/kali/.local/ && rm impacket-0.11.0.tar &&
		wget -q -O sharp.ps1 \
			"https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1" &&
		wget -q -O SharpHound.exe \
			"https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.exe" &&
		wget -q -O netexec \
			"https://github.com/Pennyw0rth/NetExec/releases/download/v1.0.0/nxc-ubuntu-latest" &&
		chmod +x netexec && sudo mv netexec /home/kali/.local/netexec
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
		wget -q -O linpeas.sh \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20230910-ae32193f/linpeas_linux_amd64" &&
		wget -q -O winpeas.exe \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20230910-ae32193f/winPEASany.exe" &&
		wget -q -O pspys \
			"https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s" &&
		wget -q -O pspy \
			"https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64"
}

echo -e "Installing tools..."
web
password
payload
active_directory
pivot
privesc
install_go
httpx_install
