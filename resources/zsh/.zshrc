setopt autocd extendedglob

#history config
HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=5000
HIST_STAMPS="mm/dd/yyyy"

#turn off beep
unsetopt beep

#vi key bindings
bindkey -v

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto      # update automatically without asking

#source aliases and env
source "$HOME/.zprofile"

for file in $HOME/.zsh/*; do
    source "$file"
done

fpath=(/tmp/zsh-completions/src $fpath)

plugins=(
git
docker
zsh-autosuggestions
zsh-syntax-highlighting
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

#displays saying in every new prompt

echo "
   __  ___                  
  / _|/ _ \ _ __  _____   _ 
 | |_| | | | '_ \|_  / | | |
 |  _| |_| | | | |/ /| |_| |
 |_|  \___/|_| |_/___|\__, |
                      |___/ 
"


#persistant ssh agent
eval $(ssh-agent) &> /dev/null

#daily use
alias t='tmux new -f ~/.tmux.conf -s $1'
alias update='sudo apt get update'
alias upgrade='sudo apt get upgrade'
alias i='sudo apt get install -y'
alias :q='exit'
alias c='clear'
alias :r='. ~/.zshrc'
alias home='cd ~'
alias cme='nxc'
alias port-scan='sudo nmap -sC -sV -p- $IP > scan.txt'
alias udp-scan='sudo nmap -sU --top-ports 10 $IP -v > udp.scan.txt'
alias stealth-scan='sudo nmap --data-length 6 -T3 -A -ttl 64 -p- $IP > stealth-scan.txt'
alias public='curl wtfismyip.com/text'
alias proxy='proxychains'
alias serve='sudo python3 -m http.server 80'
alias webserver="miniserve -p 8001"
#python3
alias py-virt='python3 -m venv .venv && source .venv/bin/activate'
alias freeze='pip freeze > requirements.txt'
alias py-install='pip install -r requirements.txt'
alias py-list='pipx list | grep package'

