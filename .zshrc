# eval "$(oh-my-posh init zsh --config "$(brew --prefix oh-my-posh)/themes/amro.omp.json")"
eval "$(oh-my-posh init zsh --config "~/.my-theme.yaml")"

# Binds for life saving
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^H' backward-kill-word

# source antidote (brew version)
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

eval "$(mcfly init zsh)"