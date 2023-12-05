!#/bin/bash

python3 -c 'import pty; pty.spawn("/bin/bash")'

export LS_OPTIONS='--color=auto'

export TERM="xterm-256color"

eval "$(dircolors)"

alias ls='ls $LS_OPTIONS'

export PS1='\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\$\[\033[00m\] '
