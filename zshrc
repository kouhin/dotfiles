# -*- mode: shell-script -*- #

if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh
zplug "zplug/zplug"

# Features
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Theme
#zplug "mafredri/zsh-async"
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Tools
zplug "rupa/z", use:z.sh
zplug "mattberther/zsh-rbenv"
zplug "syndbg/goenv", as:command, use:bin/goenv
zplug "cowboyd/zsh-rust"

zplug check --verbose || zplug install
zplug load

setopt AUTO_CD

# History
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_expand
setopt share_history

# Environment Variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export MANPATH=/usr/local/man:$MANPATH
export TERM=xterm-256color

# PATH
export PATH=/usr/local/sbin:$PATH
## Golang
if [[ -x "$(command -v goenv)" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi
## Rust
[[ -x "$(command -v cargo)" ]] && export PATH=$HOME/.cargo/bin:$PATH
## Lua
[[ -x "$(command -v luarocks)" ]] && eval `luarocks path --bin`
## Tmux
if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
## Ruby
if [[ -x "$(command -v rbenv)" ]]; then
  eval "$(rbenv init - zsh)"
  export PATH=$HOME/.rbenv/bin:$PATH
fi

## Node.js
if [[ -x "$(command -v fnm)" ]]; then
  eval "$(fnm env --use-on-cd)"
fi

export PATH=$HOME/.bin:$PATH

# Completion style
zstyle ':completion:*' menu select

# Alias
alias ddup='zplug update && brew bundle --global --cleanup'
alias e='emacs -nw'
alias ls='ls -G'
alias l='ls -al'

if [ ! -e ~/.config/starship.toml ]; then
  mkdir -p ~/.config && curl -o ~/.config/starship.toml https://starship.rs/presets/toml/pure-preset.toml
fi
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/kouhin/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"

# bun completions
[ -s "/Users/kouhin/.bun/_bun" ] && source "/Users/kouhin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
