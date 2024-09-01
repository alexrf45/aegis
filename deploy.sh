#!/bin/bash

# for deploying aegis in bash. for zsh, comment out the bash commands and uncomment the zsh lines

set -e

if command -v gum >/dev/null 2>&1; then
  echo -e "Gum is installed"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  #sudo mkdir -p /etc/apt/keyrings &&
  curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" >/dev/null 2>&1 | sudo tee /etc/apt/sources.list.d/charm.list
  sudo apt update && sudo apt install gum lolcat figlet
else
  echo "Please ensure Gum is installed via your OS package manager"
fi

echo -e "pulling image now..."

docker pull fonalex45/aegis:latest

cp script/aegis $HOME/.local/bin/.

echo 'source "$HOME/.local/bin/aegis"' >>.bashrc

# echo 'source "$HOME/.local/bin/aegis"' >>.zshrc

. ~/.bashrc
# . ~/.zshrc
