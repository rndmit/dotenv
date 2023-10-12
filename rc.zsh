export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


addpath=(
  /usr/local/bin
  /usr/local/go/bin
  /opt/homebrew/opt/gnu-sed/libexec/gnubin
  /opt/homebrew/opt/gnu-getopt/bin
  /opt/homebrew/opt/llvm/bin
  /opt/homebrew/opt/libpq/bin
  /usr/local/aws-cli
  $HOME/bin
  $HOME/.local/bin
  $HOME/.poetry/bin
  $HOME/go/bin
  ${KREW_ROOT:-$HOME/.krew}/bin
); for i ("$addpath[@]") export PATH=$PATH:$i

set -o vi
export EDITOR=vim
export GOPATH=$HOME/go
export K9SCONFIG=$HOME/.k9s

# https://github.com/rossmacarthur/sheldon
export SHELDON_CONFIG_DIR=$XDG_CONFIG_HOME/env
eval "$(sheldon source)"

[[ -f $XDG_CONFIG_HOME/env/p10k.zsh ]] && source $XDG_CONFIG_HOME/env/p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias l='lsd -lah'
alias bf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias bfc='cat $(bf) | pbcopy'
alias rand='openssl rand -base64'
alias sha256sum='shasum -a 256'
alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# git related aliases
alias gii='gi > .gitignore'
alias gitcmpb='git checkout master && git pull && git checkout -b'
alias gitc='
git commit -m "$(gum input --width 50 --placeholder "Summary of changes")" \
           -m "$(gum write --width 80 --placeholder "Details of changes (CTRL+D to finish)")"'
alias gitcp='gitc && git push'

alias m='multipass'
alias ms='multipass shell'
alias ssave='/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'
alias unquarantine='xattr -d com.apple.quarantine'
alias drri='docker run --rm -it'
alias tf='terraform'
alias tg='terragrunt'
alias ke='k edit'

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
autoload -Uz compinit  && compinit
autoload -Uz +X bashcompinit && bashcompinit
source <(kubectl completion zsh)
compdef __start_kubectl k
source <(helm completion zsh)
source <(stern --completion zsh)
source <(argocd completion zsh)
complete -C '/usr/local/bin/aws_completer' aws
complete -o nospace -C /opt/homebrew/bin/vault vault
source <(switcher init zsh)
source <(switch completion zsh)
alias kctx='switch'
alias kns='switch namespace'

function cdl {
  cd "$(llama "$@")"
}

function mkdcd {
  mkdir -p $1 && cd $1
}

function gitacp {
  git add $@
  gitcp
}

# fuzzy-find in multiple files content
function fif {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# https://github.com/ahmetb/kubectl-aliases
[ -f ~/.kubectl_aliases ] && source \
   <(cat ~/.kubectl_aliases | sed -r 's/(kubectl.*) --watch/watch \1/g')

# echo expanded kubectl aliases
function kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }

