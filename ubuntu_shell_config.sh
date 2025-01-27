#!/bin/bash
# **** Run in new terminal: curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/wsl-00/ubuntu_shell_config.sh | bash -s

# Atualização do Sistema
echo "Atualizando o sistema..."
sudo apt-get update
sudo apt-get upgrade -y

install_if_missing() {
  if ! dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "ok installed"; then
    sudo apt-get install "$1" -y
  fi
}

# Instalação de pacotes
install_if_missing curl
install_if_missing git
install_if_missing unzip
install_if_missing zsh
install_if_missing build-essential


# Alterar shell para zsh
echo "Alterando o shell para zsh..."
chsh -s $(which zsh)

# Instalação do OMZ (Oh My Zsh)
echo "Instalando o Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Registro de Atalhos
echo "Registrando atalhos..."
echo "#### Registro de Atalhos
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^H' backward-kill-word
bindkey '^X^X' edit-command-line
" >>~/.zshrc

# ZSH Package Manager - Antidote
echo "Instalando o Antidote..."
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote | zsh -s

echo $"#### ZSH Package Manager - Antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load
" >>~/.zshrc

# ASDF
echo "Instalando o ASDF..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

echo "#### ASDF
. ~/.asdf/asdf.sh
" >>~/.zprofile

# Adicionar plugins
echo "Adicionando plugins... .zsh_plugins.txt"

echo $'ohmyzsh/ohmyzsh path:plugins/asdf\n' >>~/.zsh_plugins.txt

zsh -c $'source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load
antidote install zsh-users/zsh-completions
antidote install zsh-users/zsh-autosuggestions
antidote install zsh-users/zsh-syntax-highlighting'

# Mcfly
echo "Instalando o Mcfly..."
# Caso não funcione, adicionar "--tag <versão-do-mcfly>". Ex: --tag v0.8.4
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly
echo $'#### Mcfly
eval "$(mcfly init zsh)"
' >>~/.zshrc

# Oh My Posh
echo "Instalando o Oh My Posh..."
export RUNZSH='no'
curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin

# Oh My Posh Configuration
echo "Configurando o Oh My Posh..."
curl -L -o ~/theme.oh-my-posh.yaml https://github.com/lukas-santiago/wsl-shell-config/raw/wsl-00/theme.oh-my-posh.yaml
oh-my-posh font install # --> FiraCode
echo $'
#### Oh My Posh
eval \"$(oh-my-posh init zsh --config ~/theme.oh-my-posh.yaml)\"

' >>~/.zshrc

exec zsh

# **** Run in new terminal: curl -L https://github.com/lukas-santiago/wsl-shell-config/raw/wsl-00/ubuntu_shell_config.sh | bash -s
