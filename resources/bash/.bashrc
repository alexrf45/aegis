shopt -s histappend
shopt -s checkwinsize
HISTFILE="$HOME/.kali_history"
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%Y-%m-%d %T - '

force_color_prompt=yes

source "$HOME/.bash_profile"

source "$HOME/.bash/aliases"

for file in $HOME/.bash/*; do
  source "$file"
done

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#export IP=$([ -d /proc/sys/net/ipv4/conf/tun0 ] && echo $({ ip -4 -br a sh dev tun0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null))

#PS1="\[\033[0;31m\]\342\224\214\342\224\200$([[ $? != 0 ]] && echo "[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200")[\[\033[1;97m\]\u\[\033[01;33m\]@\[\033[1;94m\]\h\[\033[01;33m\]\[\033[0;31m\]]\342\224\200\[\033[0;31m\][\[\033[1;97m\]"$IP"\[\033[0;31m\]]\342\224\200[\[\033[1;94m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\$\[\e[0m\]"

eval "$(fzf --bash)"

eval "$(starship init bash)"

# if you have a need to set up ssh presistance
#eval $(ssh-agent) >/dev/null 2>&1
#
