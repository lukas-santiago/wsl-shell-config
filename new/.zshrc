# Binds for life saving
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^H' backward-kill-word

# antitote zsh plugin manager
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

eval "$(mcfly init zsh)"
eval "$(oh-my-posh init zsh --config ~/theme.oh-my-posh.yaml)"
