#!/bin/bash

mkdir -p $HOME/.config && cp /home/kali/resources/tmux.conf /home/kali/.tmux.conf &&
	cp -r /home/kali/resources/shell-upgrade.sh /home/kali/tools/shell-upgrade.sh &&
	cp -r /home/kali/resources/recon.sh /home/kali/.local/bin/recon.sh && chmod +x /home/kali/.local/bin/recon.sh &&
	cp -r /home/kali/resources/proxychains.conf /home/kali/.proxychains/proxychains.conf &&
	cp -r /home/kali/resources/kerbrute /home/kali/.local/bin/kerbrute && chmod +x /home/kali/.local/bin/kerbrute &&
	cp /home/kali/resources/bash/history /home/kali/.history &&
	cp -r /home/kali/resources/ffuf /home/kali/.config/. &&
	cp -r /home/kali/resources/.Burpsuite /home/kali/. &&
	cp -r /home/kali/resources/zsh/aliases /home/kali/.zsh/aliases

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp /home/kali/resources/zsh/.zshrc $HOME/.zshrc

cp /home/kali/resources/zsh/.zprofile $HOME/.zprofile

cp /home/kali/resources/bash/history .commands

mkdir .zsh

cp /home/kali/resources/bash/functions.sh $HOME/.zsh/functions.sh
