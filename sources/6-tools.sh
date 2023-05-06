#!/bin/bash

# Installs commonly used tools in the tools subdirectory of the kali home directory
function tools_install() {
	cd /home/kali/tools/ &&
		wget -q -O pspy \
			"https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s" &&
		wget -q -O chisel.gz \
			"https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_linux_amd64.gz" &&
		gunzip chisel.gz &&
		wget -q -O win-chisel.gz \
			"https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_windows_amd64.gz" &&
		gunzip w-chisel.gz &&
		wget -q -O l.sh \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20230219/linpeas_linux_amd64" &&
		wget -q -O winpeas.exe \
			"https://github.com/carlospolop/PEASS-ng/releases/download/20230219/winPEASx64.exe" &&
		wget -q -O sharp.ps1 \
			"https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1" &&
		wget -q -O nc.exe \
			"https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe" &&
		wget -q \
			"https://github.com/rivermont/spidy/releases/download/1.4.0/spidy.zip" && unzip spidy.zip -d ./spidy && rm spidy.zip &&
		wget -q -O SharpHound.exe \
			"https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.exe" &&
		wget -q -O nc.exe \
			"https://gitlab.com/onemask/pentest-tools/-/raw/master/windows/nc.exe" &&
		wget -q -O nc \
			"https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/ncat" &&
		wget -q -O gofourohfour.tar.gz \
			"https://github.com/sentrium-security/GoFourOhFour/releases/download/v1.0.1/GoFourOhFour-v1.0.1-linux-amd64.tar.gz" &&
		gunzip gofourohfour.tar.gz && tar -xvf gofourohfour.tar && mv GoFourOhFour /home/kali/.local/GoFourOhFour &&
		wget -q -O cme.zip \
			"https://github.com/Porchetta-Industries/CrackMapExec/releases/download/v5.4.0/cme-ubuntu-latest-3.11.zip" &&
		unzip cme.zip && chmod +x cme && sudo mv cme /home/kali/.local/cme && rm cme.zip
}

tools_install
