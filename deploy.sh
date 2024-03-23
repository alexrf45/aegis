#!/bin/bash

echo -e "pulling image now..."

docker pull fonalex45/aegis:latest

cp sources/kali.sh $HOME/.config/.

echo 'source "$HOME/.config/kali.sh"' >>.bashrc

. ~/.bashrc
