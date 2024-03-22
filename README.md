# kali-sec

![Logo](https://ka-tet.s3.amazonaws.com/docker.png)                                                                                                                                           

![Logo](https://img.shields.io/docker/image-size/fonalex45/kali-sec)                                                                                                                             
![Logo](https://img.shields.io/docker/pulls/fonalex45/kali-sec)       

## Repeatable, immutable, and scalable Security Research w/ Docker
## Acknowledgements

 I pulled alot of inspiration from this awesome project and can only hope my project is as awesome as this one is.
 
- [Exegol - Fully featured and community-driven hacking environment](https://github.com/ThePorgs/Exegol)

## Features

- Bash functions for easy deployment and image update
- Command history logging via `script`
- Persistant containers, volumes and workspaces
- Customizable resources and tooling, config files are located in the `resources/` & `sources/` directories
- Non-root container w/ sudo
- Tmux inside the container (my favorite feature)

### Custom aliases included:

```
alias cme='nxc'
alias port-scan='sudo nmap -sC -sV -p- $IP > scan.txt'
alias udp-scan='sudo nmap -sU --top-ports 10 $IP -v > udp.scan.txt'
alias stealth-scan='sudo nmap --data-length 6 -T3 -A -ttl 64 -p- $IP > stealth-scan.txt'
alias public='curl wtfismyip.com/text'
alias t='tmux new -f ~/.tmux.conf -s $1'
alias webserver="miniserve -p 8001"
alias :q='exit'
alias home='cd ~'
alias :r='. ~/.bashrc'
alias update='sudo apt update'
alias upgrade='sudo apt-get upgrade -y'
alias i='sudo apt install -y'
alias ls='ls --color=auto'
alias command='cat $HOME/.commands'
alias proxy='proxychains'
alias serve='sudo python3 -m http.server 80'
```

## Installation

1. `git clone https://github.com/alexrf45/kali-sec.git && cd kali-sec`

2. Copy the kali function script to a desired location:

**Example:**

```bash
$ cp kali.sh ~/.zsh/. 
```

3. Source the script in .zshrc or desired shell:

**Example:**

`echo 'source "$HOME/.zsh/kali.sh"' >> .zshrc`

4. Refresh the shell:

Example: 
```bash
. ~/.bashrc or . ~/.zshrc
```

## Usage/Examples

Spawn a new container: `kali <CONTAINER_NAME>`

Start an existing container: `start <CONTAINER_NAME>`

Enter an existing container: `enter <CONTAINER_NAME>`

Stop an existing container: `stop <CONTAINER_NAME>`

Destroy an existing container: `destroy <CONTAINER_NAME>`

Update image **This will not update the image of an existing container, only for new ones**:
`pull`

Command list:

- Tired of looking for a specific command or long one liner? You can use this handy alias to search the prebuilt history for commonly used commands

```
alias command='cat $HOME/.commands'
```

TODO:
- add quick https server script
- Python wrapper
- slim testing
