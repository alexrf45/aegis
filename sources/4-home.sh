#!/bin/bash

mkdir -p $HOME/.config && cp /home/kali/resources/tmux.conf /home/kali/.tmux.conf &&
	cp -r /home/kali/resources/shell-upgrade.sh /home/kali/tools/shell-upgrade.sh &&
	cp -r /home/kali/resources/recon.sh /home/kali/.local/bin/recon.sh && chmod +x /home/kali/.local/bin/recon.sh &&
	cp -r /home/kali/resources/proxychains.conf /home/kali/.proxychains/proxychains.conf &&
	cp -r /home/kali/resources/kerbrute /home/kali/.local/bin/kerbrute && chmod +x /home/kali/.local/bin/kerbrute &&
	cp /home/kali/resources/bash/history /home/kali/.history

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

cp /home/kali/resources/bash/bashrc $HOME/.bashrc

cp /home/kali/resources/bash/profile .profile

cp /home/kali/resources/bash/aliases .aliases

cp /home/kali/resources/bash/history .commands

mkdir .bash

cp /home/kali/resources/bash/virtualenv.sh .bash/virtualenv.sh

cp /home/kali/resources/bash/functions.sh .bash/functions.sh

cp /home/kali/resources/bash/virtualenv.sh .bash/virtualenv.sh
