#!/bin/bash

function tools_install() {
    cd /home/kali/tools/ && \
	wget -q -O pspy https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s && \
	wget -q https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_linux_amd64.gz -O chisel.gz \
	&& gunzip chisel.gz && \
	wget -q https://github.com/jpillora/chisel/releases/download/v1.8.1/chisel_1.8.1_windows_amd64.gz -O w-chisel.gz \
	&& gunzip w-chisel.gz && \
	wget -q -O l.sh https://github.com/carlospolop/PEASS-ng/releases/download/20221106/linpeas.sh && \
	wget -q -O winpeas.exe https://github.com/carlospolop/PEASS-ng/releases/download/20221106/winPEASx64.exe && \
	wget -q -O sharp.ps1 https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1 && \
	wget -q -O netcat https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe && \
	wget -q https://github.com/rivermont/spidy/releases/download/1.4.0/spidy.zip && unzip spidy.zip -d ./spidy && rm spidy.zip
}
tools_install