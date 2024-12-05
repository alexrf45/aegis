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
colorize
python
ssh
tmux
git
zsh-autosuggestions
zsh-syntax-highlighting
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

#displays saying in every new prompt
source <(fzf --zsh)

#persistant ssh agent
eval $(ssh-agent) &> /dev/null

#starship prompt
#eval "$(starship init zsh)"

