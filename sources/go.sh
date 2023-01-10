#!/bin/bash

function install_go() {
    wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz \
    && rm go1.19.4.linux-amd64.tar.gz
}

function waybackurls_install() {
    wget -q -O waybackurls.tgz https://github.com/tomnomnom/waybackurls/releases/download/v0.1.0/waybackurls-linux-amd64-0.1.0.tgz \
    && gunzip waybackurls.tgz \
    && tar -C /root/.local/ -xf waybackurls.tar \
    && chmod +x /root/.local/waybackurls \
    && rm /root/waybackurls.tar
}

function httpx_install() {
    wget -q https://github.com/projectdiscovery/httpx/releases/download/v1.2.5/httpx_1.2.5_linux_amd64.zip \
    && unzip httpx_1.2.5_linux_amd64.zip -d ./httpx \
    && rm httpx_1.2.5_linux_amd64.zip \
    && mv httpx/httpx /root/.local/ \
    && rm -r httpx/

}

# function naabu_install() {

# }
install_go
waybackurls_install
httpx_install
