#!/bin/bash

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
  sudo apt-get install curl -y
fi

# Alterar shell para zsh
chsh -s $(which zsh)

# Instalação do OMZ (Oh My Zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh My Posh
curl -s https://ohmyposh.dev/install.sh | sudo bash -s

# Registro de Atalhos
echo "
# Binds for life saving
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^H' backward-kill-word
" >>~/.zshrc

# ZSH Package Manager - Antidote
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote | zsh -s
echo $'\n\n# source antidote (brew version)\n
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load\n' >>~/.zshrc

# ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '. /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh' >>~/.zprofile
# omz reload

# Nodejs
# asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# asdf install nodejs latest
# asdf global nodejs latest

# Adicionar plugins
echo $'ohmyzsh/ohmyzsh path:plugins/asdf\n' >>~/.zsh_plugins.txt

zsh -c $'source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load
antidote install zsh-users/zsh-completions
antidote install zsh-users/zsh-autosuggestions
antidote install zsh-users/zsh-syntax-highlighting'

curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
echo 'eval "$(mcfly init zsh)"' >>~/.zshrc

curl -o ~/theme.oh-my-posh.yaml https://github.com/lukas-santiago/wsl-shell-config/raw/main/theme.oh-my-posh.yaml
oh-my-posh font install # FiraCode
echo 'eval "$(oh-my-posh init zsh --config ~/.theme.oh-my-posh.yaml)"' >>~/.zshrc

exec zsh
