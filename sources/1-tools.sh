#!/bin/bash

# Installs commonly used tools in the tools subdirectory of the kali home directory

install_go() {
	wget https://go.dev/dl/go1.20.6.linux-amd64.tar.gz &&
		rm -rf /usr/local/go &&
		sudo tar -C /usr/local -xzf go1.20.6.linux-amd64.tar.gz &&
		rm go1.20.6.linux-amd64.tar.gz
}

waybackurls_install() {
	wget -q -O waybackurls.tgz https://github.com/tomnomnom/waybackurls/releases/download/v0.1.0/waybackurls-linux-amd64-0.1.0.tgz &&
		gunzip waybackurls.tgz &&
		tar -C /home/kali/.local -xf waybackurls.tar &&
		chmod +x /home/kali/.local/waybackurls &&
		rm /home/kali/tools/waybackurls.tar

}

httpx_install() {
	wget -q https://github.com/projectdiscovery/httpx/releases/download/v1.2.5/httpx_1.2.5_linux_amd64.zip &&
		unzip httpx_1.2.5_linux_amd64.zip -d ./httpx &&
		rm httpx_1.2.5_linux_amd64.zip &&
		mv httpx/httpx /home/kali/.local/http-x &&
		rm -r httpx/

}

payload() {
	cd /home/kali/tools/ &&
		wget -q -O nc.exe \
			"https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe" &&
		wget -q -O nc \
			"https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/ncat"
}

active_directory() {
	cd /home/kali/tools/ &&
		wget -q -O rubeus.exe \
			"https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe" &&
		wget -q -O certify.exe \
			"https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Certify.exe" &&
		wget -q -O cme.zip \
			"https://github.com/Porchetta-Industries/CrackMapExec/releases/download/v5.4.0/cme-ubuntu-latest-3.11.zip" &&
		unzip cme.zip && chmod +x cme && sudo mv cme /home/kali/.local/cme && rm cme.zip &&
		wget "https://github.com/fortra/impacket/releases/download/impacket_0_10_0/impacket-0.10.0.tar.gz" &&
		gunzip impacket-0.10.0.tar.gz && tar -xvf impacket-0.10.0.tar &&
		mv impacket-0.10.0/ /home/kali/.local/ && rm impacket-0.10.0.tar &&
		wget -q -O sharp.ps1 \
			"https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1" &&
		wget -q -O SharpHound.exe \
			"https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.exe"
}

pivot() {
	cd /home/kali/tools/ &&
		wget -q -O chisel.gz \
			"https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_linux_amd64.gz" &&
		gunzip chisel.gz &&
		wget -q -O win-chisel.gz \
			"https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_windows_amd64.gz" &&
		gunzip win-chisel.gz
}

privesc() {
	cd /home/kali/tools/ &&
		wget -q -O linpeas.sh \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20230611-b11e87f7/linpeas_linux_amd64" &&
		wget -q -O winpeas.exe \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20230611-b11e87f7/winPEASany.exe" &&
		wget -q -O pspy \
			"https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s"
}

echo -e "Installing tools..."
payload
active_directory
pivot
privesc
install_go
waybackurls_install
httpx_install
