# shortcut to this dotfiles path is $ZSH
export ZSH="$HOME/.zsh/"

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# Load super secret stuff
if [ -f "$HOME/.local/secrets" ]; then
    source "$HOME/.local/secrets"
fi

# # load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in "$ZSH/completions/"
do
  source $file
done

unset config_files

export TERM=xterm-256color

# User configuration

# Source git aliases again, because the `git` plugin overwrites aliases
source $HOME/.git-aliases

# Fast GHC Options for Stack
export GHC_OPTIONS='-fmax-relevant-binds=3 -fdiagnostics-color=always -fprint-expanded-synonyms -freverse-errors -fobject-code -j4 +RTS -A128m -n2m -RTS'

precmd() {
  RPROMPT=""
}

zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="(CMD)"
  () { return $__prompt_status }
  zle reset-prompt
}

zle-line-init() {
  typeset -g __prompt_status="$?"
}

zle -N zle-keymap-select
zle -N zle-line-init

autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script "$(which stack)")"

export EDITOR='nvim'

# Incremental history search
bindkey '^R' history-incremental-search-backward

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

GPG_TTY=$(tty)
export GPG_TTY

MEGAREPO_ROOT="/home/ubuntu/code/fr/megarepo/"

# Use 'hub' alias for 'git'
eval "$(hub alias -s)"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Add 'hub' completions
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

# Add kitchen sink functions
source "$ZSH/functions.zsh"
if [ -e /home/ubuntu/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
if [ -e /home/ben/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ben/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [[ $IN_NIX_SHELL ]]
then
  echo "Skipping ghcup sourcing in favor of nix-managed cabal"
else
  [ -f "/home/ben/.ghcup/env" ] && source "/home/ben/.ghcup/env"
fi
eval "$(direnv hook zsh)" # Hook direnv into directory
