#!/bin/bash

function base() {
    sudo apt-get install -y wget curl man git zsh \
	tmux ruby ruby-dev vim nano p7zip-full kali-themes \
	djvulibre-bin python3-pip python3-virtualenv libpcap-dev jq mousepad
}

base

