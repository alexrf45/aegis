#!/bin/bash

function base() {
	sudo apt-get install -y wget curl man git zsh \
		tmux ruby ruby-dev vim nano p7zip-full kali-themes \
		djvulibre-bin python3-pip python3-virtualenv libpcap-dev jq mousepad \
		firefox-esr xpdf tmuxp
}

base

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg |
	gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg >/dev/null

echo "deb https://download.sublimetext.com/ apt/stable/" |
	sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update

sudo apt-get install sublime-text
