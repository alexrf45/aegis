#!/bin/bash

function tools_install() {
    cd /home/kali/tools/ && \
	wget -q -O pspy https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s && \
	wget -q https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_linux_amd64.gz -O chisel.gz \
	&& gunzip chisel.gz && \
	wget -q https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_windows_amd64.gz -O w-chisel.gz \
	&& gunzip w-chisel.gz && \
	wget -q -O l.sh https://github.com/carlospolop/PEASS-ng/releases/download/20230219/linpeas_linux_amd64 && \
	wget -q -O winpeas.exe https://github.com/carlospolop/PEASS-ng/releases/download/20230219/winPEASx64.exe && \
	wget -q -O sharp.ps1 https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1 && \
	wget -q -O nc.exe https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe && \
	wget -q https://github.com/rivermont/spidy/releases/download/1.4.0/spidy.zip && unzip spidy.zip -d ./spidy && rm spidy.zip && \
  wget -q -O SharpHound.exe \
  "https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.exe" && \
  wget -q -O nc.exe \
  "https://gitlab.com/onemask/pentest-tools/-/raw/master/windows/nc.exe" && \
  wget -q -O nc \
  "https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/ncat"

}

tools_install
