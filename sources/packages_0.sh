#!/bin/bash

function base() {
    sudo apt-get install -y wget curl man git zsh \
	tmux ruby ruby-dev vim nano p7zip-full kali-themes \
	djvulibre-bin python3-pip libpcap-dev jq mousepad	     
}

base

