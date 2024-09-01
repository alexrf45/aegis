#!/bin/bash

web() {
  sudo apt-get install -y \
    whatweb ffuf \
    sqlmap exiftool \
    default-mysql-client \
    hurl postgresql \
    arjun sqsh
}

web_server() {
  wget "https://github.com/svenstaro/miniserve/releases/download/v0.26.0/miniserve-0.27.1-x86_64-unknown-linux-gnu" -q \
    -O miniserve && chmod +x ./miniserve && mv ./miniserve $HOME/.local/bin/miniserve
}

snyk-cli() {
  curl --compressed "https://static.snyk.io/cli/latest/snyk-linux?_gl=1*1elhg4m*_ga*MTI5NzM0MzE4LjE3MTQ5MTg0NDY.*_ga_X9SH3KP7B4*MTcxNDkyOTE4Ni4yLjEuMTcxNDkyOTU5NC41Ni4wLjA." -o snyk &&
    chmod +x ./snyk && mv ./snyk $HOME/.local/bin/snyk
}

password() {
  sudo apt-get install -y crunch
}

payload() {
  cd $HOME/.tools/ &&
    wget -q -O nc.exe \
      "https://github.com/ShutdownRepo/Exegol-resources/raw/main/windows/nc.exe" &&
    wget -q -O nc \
      "https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/ncat"
}

active_directory() {
  cd $HOME/.tools/ &&
    wget -q -O rubeus.exe \
      "https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe" &&
    wget -q -O certify.exe \
      "https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Certify.exe" &&
    wget -q -O sharp.ps1 \
      "https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1" &&
    wget -q -O SharpHound.exe \
      "https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.exe"
}

pivot() {
  cd $HOME/.tools/ &&
    wget -q -O chisel.gz \
      "https://github.com/jpillora/chisel/releases/download/v1.10.0/chisel_1.10.0_linux_amd64.gz" &&
    gunzip chisel.gz &&
    wget -q -O win-chisel.gz \
      "https://github.com/jpillora/chisel/releases/download/v1.10.0/chisel_1.10.0_windows_amd64.gz" &&
    gunzip win-chisel.gz
}

privesc() {
  cd $HOME/.tools/ &&
    wget -q -O linpeas \
      "https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh" &&
    wget -q -O winpeas.exe \
      "https://github.com/peass-ng/PEASS-ng/releases/download/20240901-df0685e9/winPEASx64_ofs.exe" &&
    wget -q -O pspys \
      "https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64s" &&
    wget -q -O pspy \
      "https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy64"
}

extra() {
  cd $HOME/.tools/ &&
    git clone https://github.com/samratashok/nishang.git nishang &&
    git clone https://github.com/gustanini/PowershellTools.git powershell-tools &&
    git clone https://github.com/aniqfakhrul/powerview.py powerview
}

web
web_server
snyk-cli
password
payload
active_directory
pivot
privesc
extra

wget -q -O $HOME/.local/bin/busybox \
  "https://busybox.net/downloads/binaries/1.35.0-x86_64-linux-musl/busybox"
