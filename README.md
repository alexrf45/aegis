# Katet

![Logo](https://ka-tet.s3.amazonaws.com/ka-tet.png)                                                                                                                                           
***"A group of people bound by faith or destiny"*** 

![Logo](https://img.shields.io/docker/image-size/fonalex45/katet)                                                                                                                             
![Logo](https://img.shields.io/docker/pulls/fonalex45/katet)                                                                                                                                  
[![Publish Docker Image](https://github.com/alexrf45/Ka-tet/actions/workflows/dockerhub.yml/badge.svg?branch=main)](https://github.com/alexrf45/Ka-tet/actions/workflows/dockerhub.yml)       

## Repeatable, immutable, and scalable Security Research w/ Docker 
## Acknowledgements

 I pulled alot of inspiration from this awesome project and can only hope my project is as awesome as this one is.
 
- [Exegol - Fully featured and community-driven hacking environment](https://github.com/ThePorgs/Exegol)

## Features

- Bash wrapper for installation, custom image build, uninstall, and operations
- Command history logging via script
- Persistant containers, volumes and workspaces
- Customizable resources and tooling, config files are located in the `resources/` & `sources/` directories
- Non-root container w/ sudo
- Tmux inside the container 
- Firefox w/ custom foxyproxy settings for Burpsuite and Socks Proxy
- Wireshark
- Bloodhound w/ custom queries
- Burpsuite (For https: recommend importing certs)

### Custom zsh aliases included:                                                                                                                                                              
                                                                                                                                                                                              
| alias      | command |
|------------|-----------------------------------------------|
| http       | 'sudo python3 -m http.server 80'              |
| reload     | '. ~/.zshrc'                                  |
| update     | 'sudo apt-get update'                         |
| t          | 'tmux -f ~/.tmux.conf'                        |
| t-session  | 'tmux new -f ~/.tmux.conf -s $1'              |
| ctf        | 'tmuxp load ~/.config/tmuxp/ctf.yaml'         |
| zcopy      | 'cp .zshrc .zlogin && cp .zlogin .zprofile'   |
| i          | 'sudo apt-get install'                        |
| public     | 'curl wtfismyip.com/text'                     |
| portscan   | 'cp /home/kali/nishang/Scan/Invoke-PortScan.ps1 .' |
| py         | 'python3                                      |


## Installation

`Katet` comes with an install script. The install script will install docker, git, curl and gum if not already installed and copy the `katet` & `katet-uninstall` to /usr/local/bin. 

NOTE: **installation location can be modified by modifying `katet-install`.** 

```bash

$ git clone https://github.com/alexrf45/Ka-tet.git

$ cd Ka-tet

$ sh katet-install

$ katet guide #shows list of avaliable commands

```
    
## Usage/Examples

Katet features user prompts for ease of use: 

`katet guide` - displays avaliable commands

`katet build` - build a custom image

`katet create` - spin up a new container using the latest or dev image

`katet custom-create` - spin up new container using user built image

`katet start` - starts specified container

`katet enter` - enters specified container

`katet stop` - stops specified container

`katet destroy` - destroys specificed container




Logging within container:

```bash 

[ Sun Dec 04 2022  2:21PM ]  [ kali@dev-local:/engagement-20xx-xx-xx-company.com ]
$ logfile $NAME

[ Sun Dec 04 2022  2:21PM ]  [ kali@dev-local:/engagement-20xx-xx-xx-company.com ]
$ cd $NAME

```


Command list:

- Tired of looking for a specific command or long one liner? You can use this handy alias to search the prebuilt zsh history for commonly used commands, comes included in the container .zshrc.

```
alias commands='history | cut -c 6-'
```
## Demo

`katet create`

[![asciicast](https://asciinema.org/a/QfqdrYlf5gCFIx70ZMEu4XBHV.svg)](https://asciinema.org/a/QfqdrYlf5gCFIx70ZMEu4XBHV)