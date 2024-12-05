#!/bin/bash

mkdir -p $HOME/.config && mkdir -p $HOME/.zsh &&
  cp -r /home/kali/resources/tmux.conf $HOME/.tmux.conf &&
  cp -r /home/kali/resources/shell-upgrade.sh $HOME/.tools/shell-upgrade.sh &&
  cp -r /home/kali/resources/recon.sh $HOME/.local/bin/recon.sh && chmod +x $HOME/.local/bin/recon.sh &&
  cp -r /home/kali/resources/proxychains.conf $HOME/.proxychains/proxychains.conf &&
  cp -r /home/kali/resources/kerbrute $HOME/.local/bin/kerbrute && chmod +x /$HOME/.local/bin/kerbrute &&
  cp -r /home/kali/resources/smbserver.py $HOME/.tools/smbserver.py &&
  cp -r /home/kali/resources/zsh/history $HOME/.history

#cp -r /home/kali/resources/starship.toml $HOME/.config/starship.toml

wget -q "https://github.com/junegunn/fzf/releases/download/0.53.0/fzf-0.53.0-linux_amd64.tar.gz" -O fzf.tar.gz &&
  tar xzf fzf.tar.gz && chmod +x fzf && mv fzf $HOME/.local/bin/.

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp /home/kali/resources/zsh/.zshrc $HOME/.zshrc

cp /home/kali/resources/zsh/kali.zsh-theme $HOME/.oh-my-zsh/custom/themes/kali.zsh-theme

cp /home/kali/resources/zsh/functions.sh $HOME/.zsh/functions.sh

cp /home/kali/resources/zsh/aliases $HOME/.zsh/aliases

cp /home/kali/resources/zsh/.zprofile $HOME/.zprofile

rm $HOME/fzf.tar.gz
