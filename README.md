
![Logo](https://ka-tet.s3.amazonaws.com/ka-tet.png)

***"A group of people bound by faith or destiny"***

![Logo](https://img.shields.io/docker/image-size/fonalex45/katet)
![Logo](https://img.shields.io/docker/pulls/fonalex45/katet)
[![Publish Docker Image](https://github.com/alexrf45/Ka-tet/actions/workflows/dockerhub.yml/badge.svg?branch=main)](https://github.com/alexrf45/Ka-tet/actions/workflows/dockerhub.yml)
## Repeatable, immutable, and scalable Security Research w/ Docker


## Acknowledgements

 I pulled alot of inspiration from this awesome project and can only hope my project is as awesome as this one is.
 
- [Exegol - Fully featured and community-driven hacking environment](https://github.com/ThePorgs/Exegol)

## Fully Tested on: Debian 11, Arch Linux 6.2.13-zen-1-zen, and Kali Linux 2023.1

Docker is a life saver for reproducing a consistent environment for various types of assessments. Instead of wasting time configuring a Kali Linux virtual machine, this Docker image provides a repeatable environment for any type of engagement. 

## Features

- Command history logging
- Terminal Output logging using script: `logfile $NAME`
- Persistant containers or just volume/workspace. 
- Customizable resources and tooling, config files are located in the resources/ & sources/ directories
- Non-root container
- Tmux inside the container
- UPDATE #3: I installed the latest crackmapexec instead of the kali package
- UPDATE #4: Firefox can now be launched from the container.
  Just run `firefox -P f0zy &`
  - Extensions included:
      - Wappalyzer
      - Foxyproxy extensions with configs for burp, TOR and basic SOCKS proxy.
  MAJOR UPDATE: I've built a bash wrapper with user input for ease of use.

### Custom zsh aliases included: 

| alias      | command                                                                                              |
|------------|------------------------------------------------------------------------------------------------------|
| http       | 'sudo python3 -m http.server 80'                                                                     |
| reload     | '. ~/.zshrc'                                                                                         |
| update     | 'sudo apt-get update'                                                                                |
| t          | 'tmux -f ~/.tmux.conf'                                                                               |
| zcopy      | 'cp .zshrc .zlogin && cp .zlogin .zprofile'                                                          |
| i          | 'sudo apt-get install'                                                                               |
| public     | 'curl wtfismyip.com/text'                                                                                   |
| speedtest  | 'curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'     |
| portscan   | 'cp /root/nishang/Scan/Invoke-PortScan.ps1 .'                                                         |

# Usage/Examples:

## Initial Set up:

```bash

$ git clone https://github.com/alexrf45/Ka-tet.git

$ cd Ka-tet

$ chmod +x katet

$ sudo cp katet /usr/local/bin

$ cp USAGE.md ~/.local/USAGE.md

$ katet guide

```
Further instructions are listed in the guide command.

## Logging: 

```bash
$ kali

[ Sun Dec 04 2022  2:21PM ]  [ kali@dev-local:/engagement-20xx-xx-xx-company.com ]
 $ 

$ logfile $NAME

$ cd /$NAME
```
## Customization:

- You can build the image locally: 
```bash

$ cd Ka-tet

$ export IMAGE_NAME=<desired image name and tag>

$ docker build -t $IMAGE_NAME .

```

- Feel free to edit the `zshrc` and add command examples in the `history` based on desired configuration


## Command list:

- Tired of looking for a specific command or long one liner? You can use this handy alias to search the prebuilt zsh history
for commonly used commands. This is included in the container zshrc.

```
alias commands='history | cut -c 6-'
```

