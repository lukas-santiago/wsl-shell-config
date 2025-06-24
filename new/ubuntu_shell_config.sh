#!/bin/bash
# **** Run in new terminal: curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/main/new/ubuntu_shell_config.sh | bash -s

# Atualização do Sistema
sudo apt-get update
sudo apt-get upgrade -y

# Verifica para saber se o ZSH está instalado
if [ $(dpkg-query -W -f='${Status}' zsh 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  sudo apt-get install zsh -y
fi

if [ $(dpkg-query -W -f='${Status}' build-essential 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  sudo apt-get install build-essential -y
fi

if [ $(dpkg-query -W -f='${Status}' unzip 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  sudo apt-get install unzip -y
fi

if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  sudo apt-get install curl -y
fi

if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  sudo apt-get install git -y
fi

# Alterar shell para zsh
chsh -s $(which zsh)

# Instalação do OMZ (Oh My Zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Novo ~/.zshrc limpo
curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/main/new/.zshrc > ~/.zshrc
curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/main/new/.zprofile > ~/.zprofile

# Oh My Posh
export RUNZSH='no'
curl -s https://ohmyposh.dev/install.sh | sudo bash -s

# ZSH Package Manager - Antidote
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote | zsh -s

# ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

# Nodejs
# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# asdf install nodejs latest
# asdf global nodejs latest

# Adicionar plugins
curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/main/new/.zsh_plugins.txt | envsubst > ~/.zsh_plugins.txt
zsh -c $'source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load'

# Mcfly
# Caso não funcione, adicionar "--tag <versão-do-mcfly>". Ex: --tag v0.8.4
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly

# Oh My Posh Configuration
curl -s https://ohmyposh.dev/install.sh | bash -s
curl -L -o ~/theme.oh-my-posh.yaml https://github.com/lukas-santiago/wsl-shell-config/raw/main/theme.oh-my-posh.yaml
/home/lk/.local/bin/oh-my-posh font install FiraCode # --> FiraCode

exec zsh

# **** Run in new terminal: curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/main/new/ubuntu_shell_config.sh | bash -s
