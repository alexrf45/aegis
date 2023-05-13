#!/bin/bash

sudo apt update -y && sudo apt install curl git
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum

chmod +x katet &&
	sudo cp katet /usr/local/bin

mkdir $HOME/.katet && cp USAGE.md $HOME/.katet/USAGE.md
