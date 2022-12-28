#!/bin/bash

function install_go() {
    wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz \
    && rm go1.19.4.linux-amd64.tar.gz
}

function install_go_tools() {
    wget -q -O waybackurls.tgz https://github.com/tomnomnom/waybackurls/releases/download/v0.1.0/waybackurls-linux-amd64-0.1.0.tgz \
    && gunzip waybackurls.tgz \
    && tar -C /root/.local/ -xf waybackurls.tar \
    && chmod +x /root/.local/waybackurls \
    && rm /root/waybackurls.tar
}
install_go
install_go_tools