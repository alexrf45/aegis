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

ZSH_THEME="kali"

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

eval "$(starship init zsh)"
